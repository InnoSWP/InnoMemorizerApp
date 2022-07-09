import 'package:flutter/material.dart';
//import 'package:alan_voice/alan_voice.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kDebugMode, kIsWeb;
import 'package:flutter_tts/flutter_tts.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
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

enum TtsState { playing, stopped, paused, continued }

class Memorize extends State<MemorizeScreen> {
  late FlutterTts flutterTts;
  double volume = 1.0;
  double pitch = 1.0;
  double rate = 0.5;
  TtsState ttsState = TtsState.stopped;
  bool _hasInternetConnection = true;

  int _currentIndex = 0;

  bool isPlayingNow = false;
  bool buttonsAreActive = true;
  bool isOnRepeat = false;

  int amountRepeated = 0;

  final ItemScrollController _scrollController = ItemScrollController();
  final List<Widget> _items = [];

  bool get isIOS => !kIsWeb && Platform.isIOS;

  bool get isAndroid => !kIsWeb && Platform.isAndroid;

  bool get isWindows => !kIsWeb && Platform.isWindows;

  bool get isWeb => kIsWeb;

  Future _getDefaultEngine() async {
    var engine = await flutterTts.getDefaultEngine;
    if (engine != null) {
      if (kDebugMode) {
        print(engine);
      }
    }
  }

  initTts() {
    flutterTts = FlutterTts();
    _setAwaitOptions();
    if (isAndroid) {
      _getDefaultEngine();
    }
    flutterTts.setStartHandler(() {
      setState(() {
        if (kDebugMode) {
          print("Playing");
        }
        ttsState = TtsState.playing;
      });
    });
    flutterTts.setCompletionHandler(() {
      setState(() {
        if (kDebugMode) {
          print("Complete");
        }
        ttsState = TtsState.stopped;
      });
    });
    flutterTts.setCancelHandler(() {
      setState(() {
        if (kDebugMode) {
          print("Cancel");
        }
        ttsState = TtsState.stopped;
      });
    });
    if (isWeb || isIOS || isWindows) {
      flutterTts.setPauseHandler(() {
        setState(() {
          if (kDebugMode) {
            print("Paused");
          }
          ttsState = TtsState.paused;
        });
      });
      flutterTts.setContinueHandler(() {
        setState(() {
          if (kDebugMode) {
            print("Continued");
          }
          ttsState = TtsState.continued;
        });
      });
    }
    flutterTts.setErrorHandler((msg) {
      setState(() {
        if (kDebugMode) {
          print("error: $msg");
        }
        ttsState = TtsState.stopped;
      });
    });
  }

  Future _setAwaitOptions() async {
    await flutterTts.awaitSpeakCompletion(true);
  }

  Future _stop() async {
    var result = await flutterTts.stop();
    if (result == 1) setState(() => ttsState = TtsState.stopped);
  }

  // Future _pause() async {
  //   var result = await flutterTts.pause();
  //   if (result == 1) setState(() => ttsState = TtsState.paused);
  // }

  @override
  void dispose() {
    super.dispose();
    flutterTts.stop();
  }

  Future _speak() async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setVolume(volume);
    await flutterTts.setSpeechRate(rate);
    await flutterTts.setPitch(pitch);

    await flutterTts.speak(widget.sentences[_currentIndex]!);

    if (isPlayingNow) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      int numberOfRepetitions = (prefs.getInt('numberOfRepetitions') ?? 1);

      if (isOnRepeat) {
      } else {
        if (prefs.getBool('repeatEverySentence') ?? false) {
          if (amountRepeated + 1 < numberOfRepetitions) {
            ++amountRepeated;
          } else {
            incrementCurrentIndex();
            amountRepeated = 0;
          }
        } else {
          incrementCurrentIndex();
        }
      }

      setState(() {
        _items[_currentIndex] = getHighlightedSentence(_currentIndex);
        if (_currentIndex > 0) {
          _items[_currentIndex - 1] = getCasualSentence(_currentIndex - 1);
        }
        scrollToIndex(_currentIndex);
      });

      if (isPlayingNow) {
        //Because it can be changed in the outer block
        _speak();
      }
    }
  }

//   Memorize() {
//     voiceCommand();
//   }

  void scrollToIndex(int index) {
    Future.delayed(const Duration(milliseconds: 100), () {
      _scrollController.scrollTo(
          index: _currentIndex, duration: const Duration(milliseconds: 200));
    });
  }

  void switchHighlightedSentence(int oldIndex, int newIndex) {
    _items[oldIndex] = getCasualSentence(oldIndex);
    _items[newIndex] = getHighlightedSentence(newIndex);
  }

  void onClickPlayPause() {
    if (buttonsAreActive) {
      if (!isPlayingNow) {
        setState(() {
          isPlayingNow = true;

          buttonsAreActive = false;
          Future.delayed(const Duration(milliseconds: 1000), () {
            setState(() {
              buttonsAreActive = true;
            });
          });
        });

        _speak();
      } else {
        setState(() {
          _stop();
          isPlayingNow = false;
        });
      }
    }
  }

  void onClickRewind() {
    if (buttonsAreActive) {
      setState(() {
        if (_currentIndex > 0) {
          _stop();
          isPlayingNow = false;
          switchHighlightedSentence(_currentIndex, _currentIndex - 1);

          --_currentIndex;
          scrollToIndex(_currentIndex);
        }
      });
    }
  }

  void onRepeat() {
    setState(() => isOnRepeat = !isOnRepeat);
  }

  void onClickForward() {
    if (buttonsAreActive) {
      setState(() {
        if (_currentIndex < widget.sentences.length - 1) {
          isPlayingNow = false;
          _stop();
          switchHighlightedSentence(_currentIndex, _currentIndex + 1);

          ++_currentIndex;
          scrollToIndex(_currentIndex);
        }
      });
    }
  }

  @override
  void initState() {
    initTts();
    super.initState();
    SharedPreferences.getInstance().then((prefs) {
      prefs.setInt('numberOfRepetitions', 1);
      prefs.setBool('repeatEverySentence', false);
      prefs.setBool('enableVoiceCommand', true);
    });
    for (int i = 0; i < widget.sentences.length; i++) {
      _items.add(i == _currentIndex
          ? getHighlightedSentence(i)
          : getCasualSentence(i));
    }

    InternetConnectionChecker().onStatusChange.listen((status) {
      final hasInternetConnection =
          status == InternetConnectionStatus.connected;

      setState(() => _hasInternetConnection = hasInternetConnection);
    });
  }

  Widget getCurrentSentences() {
    return ScrollablePositionedList.separated(
      itemScrollController: _scrollController,
      itemCount: _items.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            if (index == _currentIndex) return;
            _stop();
            switchHighlightedSentence(_currentIndex, index);
            scrollToIndex(index);
            setState(() {
              _currentIndex = index;
              isPlayingNow = false;
            });
          },
          child: _items[index],
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return Divider(
          thickness: 1,
          indent: MediaQuery.of(context).size.width * 0.035,
          endIndent: MediaQuery.of(context).size.width * 0.035,
          color: CustomColors.greyBorder.withOpacity(0.5),
        );
      },
    );
  }

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
          icon: const Icon(Icons.arrow_back_rounded,
              color: CustomColors.greyText, size: 40),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text('Memorize',
            style: TextStyle(
                color: CustomColors.primary,
                fontWeight: FontWeight.w700,
                fontSize: 32)),
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
                Icons.settings_rounded,
                color: CustomColors.greyText,
                size: 40,
              ))
        ],
      ),
      body: Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).size.width * 0.05),
        child: Column(
          children: <Widget>[
            (!_hasInternetConnection
                ? Container(
                    padding: const EdgeInsets.only(left: 2, right: 2),
                    child: Row(children: const [
                      Text(
                        "Voice commands deactivated due to networks missing",
                        style: TextStyle(color: Colors.red),
                      ),
                      Icon(Icons.warning, color: Colors.red),
                    ]))
                : Container()),
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
                          onPressed: onRepeat,
                          icon: const Icon(
                            Icons.repeat_rounded,
                            size: 34,
                          ),
                          color: isOnRepeat
                              ? Colors.deepPurple
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

//   voiceCommand() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     if (prefs.getBool('enableVoiceCommand') ?? false) {
//       /// Init Alan Button with project key from Alan Studio
//       AlanVoice.addButton(
//           "8118d5e4d24668be5a3c671a4e29cd092e956eca572e1d8b807a3e2338fdd0dc/stage");

//       /// Handle commands from Alan Studio
//       AlanVoice.onCommand.add((command) async {
//         if (command.data["command"] == "play") {
//           AlanVoice.deactivate();
//           _stop();
//           if (!isPlayingNow) {
//             onClickPlayPause();
//           }
//         } else if (command.data["command"] == "stop") {
//           AlanVoice.deactivate();
//           _stop();
//           if (isPlayingNow) {
//             onClickPlayPause();
//           }
//         } else if (command.data["command"] == "back") {
//           AlanVoice.deactivate();
//           _stop();
//           onClickRewind();
//         } else if (command.data["command"] == "forward") {
//           AlanVoice.deactivate();
//           _stop();
//           onClickForward();
//         }
//       });
//     }
//   }

  void incrementCurrentIndex() {
    if (_currentIndex + 1 < widget.sentences.length) {
      ++_currentIndex;
    } else {
      isPlayingNow = false;
    }
  }
}
