import 'package:flutter/material.dart';
import 'package:alan_voice/alan_voice.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '/../widgets/options.dart';
import '/../common/theme.dart';

class MemorizeScreen extends StatefulWidget {
  const MemorizeScreen({Key? key, required this.title, required this.sentences})
      : super(key: key);

  final String title;
  final List<String?> sentences;

  @override
  State<StatefulWidget> createState() => Memorize();
}

class Memorize extends State<MemorizeScreen> {
  int _currentIndex = 0;
  int _numberOfRepetitions = 0;

  final ItemScrollController _scrollController = ItemScrollController();
  final List<Widget> _items = [];

  final repeatTextController = TextEditingController();

  Memorize() {
    /// Init Alan Button with project key from Alan Studio
    AlanVoice.addButton(
        "8118d5e4d24668be5a3c671a4e29cd092e956eca572e1d8b807a3e2338fdd0dc/stage");

    /// Handle commands from Alan Studio
    AlanVoice.onCommand.add((command) async {
      debugPrint("got new command ${command.toString()}");

      if (command.data["command"] == "finishedPlaying") {
        //This will not fire if Alan is disabled

        //Therefore we don't even need to check isPlayingNow
        if (_currentIndex + 1 < widget.sentences.length) {
          setState(() {
            if (isOnRepeat) {
              if (amountRepeated + 1 < _numberOfRepetitions) {
                ++amountRepeated;
              } else {
                onRepeat();
              }
            } else {
              ++_currentIndex;
            }

            _items[_currentIndex] = getHighlightedSentence(_currentIndex);
            _items[_currentIndex - 1] = getCasualSentence(_currentIndex - 1);
            _scrollController.scrollTo(
                index: _currentIndex,
                duration: const Duration(milliseconds: 400));
          });
          playSentence();
        }
      } else if (command.data["command"] == "play") {
        if (!isPlayingNow) {
          onClickPlayPause();
        }
      } else if (command.data["command"] == "stop") {
        if (isPlayingNow) {
          onClickPlayPause();
        }
      } else if (command.data["command"] == "back") {
        onClickRewind();
      } else if (command.data["command"] == "forward") {
        onClickForward();
      }
    });
  }

  @override
  void dispose() {
    repeatTextController.dispose();
    super.dispose();
  }

  bool isPlayingNow = false;
  bool buttonsAreActive = true;
  bool isOnRepeat = false;

  int amountRepeated = 0;

  void onClickPlayPause() {
    if (buttonsAreActive) {
      if (!isPlayingNow) {
        AlanVoice.activate();

        setState(() {
          isPlayingNow = true;

          buttonsAreActive = false;
          Future.delayed(const Duration(milliseconds: 1000), () {
            setState(() {
              buttonsAreActive = true;
            });
          });
        });

        playSentence();
      } else {
        AlanVoice.deactivate();

        setState(() {
          isPlayingNow = false;
        });
      }
    }
  }

  void playSentence() {
    //await AlanVoice.playText(widget.sentences[_currentIndex]!);
    //var lastCur = _currentIndex;

    //AlanVoice.deactivate();

    //Necessary to prevent bugs with voice falling behind fast rewind and forward button clicking
    //Because when callProjectApi is called even if you call the second, the first will say
    //Future.delayed(const Duration(milliseconds: 1000), () {
    //  if (lastCur == _currentIndex) {
    //AlanVoice.activate();

    var params = jsonEncode({"text": widget.sentences[_currentIndex]!});
    AlanVoice.callProjectApi("script::say", params);
    //  }
    //});
    //playSentence();
  }

  void onClickRewind() {
    if (buttonsAreActive) {
      setState(() {
        if (_currentIndex > 0) {
          --_currentIndex;

          _items[_currentIndex] = getHighlightedSentence(_currentIndex);
          _items[_currentIndex + 1] = getCasualSentence(_currentIndex + 1);
          _scrollController.scrollTo(
              index: _currentIndex,
              duration: const Duration(milliseconds: 400));
          //If you just do this it waits until the previous sentence is said
          //playSentence();

          //AlanVoice.deactivate();
          //AlanVoice.activate();

          AlanVoice.deactivate();
          isPlayingNow = false;
        }
      });
    }
  }

  void onRepeat() {
    amountRepeated = 0;
    setState(() {
      isOnRepeat = !isOnRepeat;
      loadNumberOfRepetitions();
    });
  }

  void onClickForward() {
    if (buttonsAreActive) {
      setState(() {
        if (_currentIndex < widget.sentences.length - 1) {
          ++_currentIndex;

          _items[_currentIndex - 1] = getCasualSentence(_currentIndex - 1);
          _items[_currentIndex] = getHighlightedSentence(_currentIndex);
          _scrollController.scrollTo(
              index: _currentIndex,
              duration: const Duration(milliseconds: 400));

          //If you just do this it waits until the previous sentence is said
          //playSentence();

          //AlanVoice.deactivate();
          //AlanVoice.activate();

          AlanVoice.deactivate();
          isPlayingNow = false;
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    loadNumberOfRepetitions();
    for (int i = 0; i < widget.sentences.length; i++) {
      _items.add(i == _currentIndex
          ? getHighlightedSentence(i)
          : getCasualSentence(i));
    }
  }

  Widget getCurrentSentences() {
    return ScrollablePositionedList.separated(
      itemScrollController: _scrollController,
      itemCount: _items.length,
      itemBuilder: (context, index) {
        return _items[index];
      },
      separatorBuilder: (BuildContext context, int index) {
        return Container(
          height: 1,
          color: CustomColors.greyBorder,
          child: const Divider(color: CustomColors.greyBorder),
        );
      },
    );
  }

  // Widget getCurrentSentences2() {
  //   if (widget.sentences.length >= 3) {
  //     if (_currentIndex == 0) {
  //       return Column(children: <Widget>[
  //         getHighlightedSentence(_currentIndex),
  //         getCasualSentence(_currentIndex + 1),
  //         getCasualSentence(_currentIndex + 2),
  //       ]);
  //     } else if (_currentIndex == widget.sentences.length - 1) {
  //       return Column(children: <Widget>[
  //         getCasualSentence(_currentIndex - 2),
  //         getCasualSentence(_currentIndex - 1),
  //         getHighlightedSentence(_currentIndex),
  //       ]);
  //     } else {
  //       return Column(children: <Widget>[
  //         getCasualSentence(_currentIndex - 1),
  //         getHighlightedSentence(_currentIndex),
  //         getCasualSentence(_currentIndex + 1),
  //       ]);
  //     }
  //   } else if (widget.sentences.length == 2) {
  //     if (_currentIndex == 0) {
  //       return Column(children: <Widget>[
  //         getHighlightedSentence(_currentIndex),
  //         getCasualSentence(_currentIndex + 1),
  //       ]);
  //     } else {
  //       return Column(children: <Widget>[
  //         getCasualSentence(_currentIndex - 1),
  //         getHighlightedSentence(_currentIndex),
  //       ]);
  //     }
  //   }
  //
  //   return getHighlightedSentence(_currentIndex);
  // }

  Widget getCasualSentence(int index) {
    return Container(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Text(
                '${index + 1}',
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 22,
                  color: Color.fromRGBO(0, 0, 0, 0.5),
                ),
              ),
            ),
            Flexible(
              child: Text(
                widget.sentences[index]!,
                style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 28,
                    color: Color.fromRGBO(115, 129, 255, 1),
                    fontFamily: 'RobotoMono'),
              ),
            ),
          ],
        ));
  }

  Widget getHighlightedSentence(int index) {
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Text(
              '${index + 1}',
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 24,
                color: Color.fromRGBO(0, 0, 0, 0.75),
              ),
            ),
          ),
          Flexible(
            child: Text(
              widget.sentences[index]!,
              style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 36,
                  color: Color.fromRGBO(34, 56, 255, 1),
                  fontFamily: 'RobotoMono'),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: CustomColors.background,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,
              color: CustomColors.greyText, size: 40),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text('Memorize',
            style: TextStyle(
                color: CustomColors.primary,
                fontWeight: FontWeight.w700,
                fontSize: 28)),
        actions: [
          IconButton(
              padding: EdgeInsets.only(
                  right: MediaQuery.of(context).size.width * 0.02),
              onPressed: () {
                setState(() {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const OptionsScreen(),
                    ),
                  );
                });
              },
              icon: const Icon(
                Icons.settings,
                color: CustomColors.greyText,
                size: 40,
              ))
        ],
      ),
      body: Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).size.width * 0.05),
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.05,
                right: MediaQuery.of(context).size.width * 0.05,
              ),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: CustomColors.greyBorder,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.55,
                    child: getCurrentSentences()),
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.05,
                right: MediaQuery.of(context).size.width * 0.05,
              ),
              child: Container(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.05,
                    right: MediaQuery.of(context).size.width * 0.05),
                child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.10,
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            '${_currentIndex + 1}/${widget.sentences.length} complete',
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 24,
                              color: Color.fromRGBO(0, 0, 0, 0.5),
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            onRepeat();
                          },
                          icon: const Icon(
                            Icons.repeat_rounded,
                            size: 34,
                          ),
                          color: isOnRepeat
                              ? Colors.lightGreen
                              : const Color.fromRGBO(0, 0, 0, 0.5),
                        )
                      ],
                    )),
              ),
            ),
            Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.025,
                    right: MediaQuery.of(context).size.height * 0.04),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.05),
                      child: Ink(
                        decoration: ShapeDecoration(
                          color: Color.fromRGBO(
                              72, 62, 168, buttonsAreActive ? 1 : 0.3),
                          shape: const CircleBorder(),
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.skip_previous_rounded),
                          color: Colors.white,
                          onPressed: onClickRewind,
                          iconSize: 40,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5, right: 5),
                      child: Ink(
                        decoration: ShapeDecoration(
                          color: Color.fromRGBO(
                              72, 62, 168, buttonsAreActive ? 1 : 0.3),
                          shape: const CircleBorder(),
                        ),
                        child: IconButton(
                          icon: isPlayingNow
                              ? const Icon(Icons.pause_rounded)
                              : const Icon(Icons.play_arrow_rounded),
                          color: Colors.white,
                          onPressed: onClickPlayPause,
                          iconSize: 70,
                        ),
                      ),
                    ),
                    Ink(
                      decoration: ShapeDecoration(
                        color: Color.fromRGBO(
                            72, 62, 168, buttonsAreActive ? 1 : 0.3),
                        shape: const CircleBorder(),
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.skip_next_rounded),
                        color: Colors.white,
                        onPressed: onClickForward,
                        iconSize: 40,
                      ),
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }

  void loadNumberOfRepetitions() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _numberOfRepetitions = (prefs.getInt('numberOfRepetitions') ?? 1);
    });
  }
}
