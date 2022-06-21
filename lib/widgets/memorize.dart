import 'package:flutter/material.dart';
import 'package:alan_voice/alan_voice.dart';
import '../common/theme.dart';

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

  Memorize() {
    /// Init Alan Button with project key from Alan Studio
    AlanVoice.addButton(
        "4bcdc8339b280a7d4af44a9cc1b6f2cb2e956eca572e1d8b807a3e2338fdd0dc/stage");

    /// Handle commands from Alan Studio
    AlanVoice.onCommand.add((command) {
      debugPrint("got new command ${command.toString()}");
    });
  }

  Widget getCurrentSentences() {
    if (widget.sentences.length >= 3) {
      if (_currentIndex == 0) {
        return Column(
            children: <Widget>[
              getHighlightedSentence(_currentIndex),
              getCasualSentence(_currentIndex + 1),
              getCasualSentence(_currentIndex + 2),
            ]
        );
      } else if (_currentIndex == widget.sentences.length - 1) {
        return Column(
            children: <Widget>[
              getCasualSentence(_currentIndex - 2),
              getCasualSentence(_currentIndex - 1),
              getHighlightedSentence(_currentIndex),
            ]
        );
      } else {
        return Column(
            children: <Widget>[
              getCasualSentence(_currentIndex - 1),
              getHighlightedSentence(_currentIndex),
              getCasualSentence(_currentIndex + 1),
            ]
        );
      }
    } else if (widget.sentences.length == 2) {
      if (_currentIndex == 0) {
        return Column(
            children: <Widget>[
              getHighlightedSentence(_currentIndex),
              getCasualSentence(_currentIndex + 1),
            ]
        );
      } else {
        return Column(
            children: <Widget>[
              getCasualSentence(_currentIndex - 1),
              getHighlightedSentence(_currentIndex),
            ]
        );
      }
    }

    return getHighlightedSentence(_currentIndex);
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
          )
        ],
      )
    );
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
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
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
              onPressed: () {},
              icon: const Icon(
                Icons.settings,
                color: CustomColors.greyText,
                size: 40,
              ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 40),
        child: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: CustomColors.blueBorder,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: <Widget>[

                    getCurrentSentences(),

                    Container(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: Row(
                        children: [
                          Expanded(
                              child: Container(
                            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                            child: Text(
                              '${_currentIndex + 1}/${widget.sentences.length} complete',
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 24,
                                color: Color.fromRGBO(0, 0, 0, 0.5),
                              ),
                            ),
                          )),
                          Container(
                              padding: const EdgeInsets.fromLTRB(0, 0, 10, 10),
                              child: Column(
                                children: [
                                  IconButton(
                                    iconSize: 40,
                                    icon: const Icon(
                                      Icons.refresh,
                                      color: Colors.black,
                                    ),
                                    onPressed: () {},
                                  ),
                                  const Text(
                                    'Repeat',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 22,
                                      color: Color.fromRGBO(0, 0, 0, 0.5),
                                    ),
                                  ),
                                ],
                              ))
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Container(
                padding: const EdgeInsets.fromLTRB(0, 110, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Ink(
                      decoration: const ShapeDecoration(
                        color: Color.fromRGBO(72, 62, 168, 1),
                        shape: CircleBorder(),
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.fast_rewind_outlined),
                        color: Colors.white,
                        onPressed: () {
                          setState(() {
                            if (_currentIndex > 0) {
                              --_currentIndex;
                            }
                          });
                        },
                        iconSize: 50,
                      ),
                    ),
                    Ink(
                      decoration: const ShapeDecoration(
                        color: Color.fromRGBO(72, 62, 168, 1),
                        shape: CircleBorder(),
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.play_arrow),
                        color: Colors.white,
                        onPressed: () {},
                        iconSize: 50,
                      ),
                    ),
                    Ink(
                      decoration: const ShapeDecoration(
                        color: Color.fromRGBO(72, 62, 168, 1),
                        shape: CircleBorder(),
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.fast_forward_outlined),
                        color: Colors.white,
                        onPressed: () {
                          setState(() {
                            if (_currentIndex < widget.sentences.length - 1) {
                              ++_currentIndex;
                            }
                          });
                        },
                        iconSize: 50,
                      ),
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
