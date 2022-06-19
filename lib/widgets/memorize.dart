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

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: CustomColors.background,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,
              color: CustomColors.greyText, size: 40),
          onPressed: () {},
        ),
        title: const Text('All start song',
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
                    Container(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                            child: const Text(
                              '1',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 22,
                                color: Color.fromRGBO(0, 0, 0, 0.5),
                              ),
                            ),
                          ),
                          const Flexible(
                            child: Text(
                              'Somebody once told me the world is gonna roll me',
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 28,
                                  color: Color.fromRGBO(115, 129, 255, 1),
                                  fontFamily: 'RobotoMono'),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                            child: const Text(
                              '2',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 24,
                                color: Color.fromRGBO(0, 0, 0, 0.75),
                              ),
                            ),
                          ),
                          Flexible(
                            child: Text(
                              widget.sentences[_currentIndex]!,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 36,
                                  color: Color.fromRGBO(34, 56, 255, 1),
                                  fontFamily: 'RobotoMono'),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                            child: const Text(
                              '3',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 22,
                                color: Color.fromRGBO(0, 0, 0, 0.5),
                              ),
                            ),
                          ),
                          const Flexible(
                            child: Text(
                              'She was looking kind of dumb with her finger and her thumb',
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 28,
                                  color: Color.fromRGBO(115, 129, 255, 1),
                                  fontFamily: 'RobotoMono'),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: Row(
                        children: [
                          Expanded(
                              child: Container(
                            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                            child: const Text(
                              '2/306 complete',
                              style: TextStyle(
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
