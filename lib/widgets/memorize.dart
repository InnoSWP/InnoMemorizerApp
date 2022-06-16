import 'package:flutter/material.dart';
import '../common/theme.dart';

class MemorizeScreen extends StatefulWidget {
  const MemorizeScreen({Key? key, required this.title, required this.sentences})
      : super(key: key);

  final String title;
  final String sentences;

  @override
  State<StatefulWidget> createState() => Memorize();
}

class Memorize extends State<MemorizeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.fromLTRB(0, 70, 0, 15),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: IconButton(
                    iconSize: 40,
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                    ),
                    onPressed: () {},
                  ),
                ),
                Expanded(
                  /*1*/
                  child: Text(
                    widget.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 28,
                      color: CustomColors.primary,
                    ),
                  ),
                ),
                /*3*/
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: IconButton(
                    iconSize: 30,
                    icon: const Icon(
                      Icons.settings,
                      color: Colors.black,
                    ),
                    onPressed: () {},
                  ),
                )
              ],
            ),
          ),
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
                            widget.sentences,
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
              padding: const EdgeInsets.fromLTRB(100, 50, 0, 0),
              child: Row(
                children: [
                  Ink(
                    decoration: const ShapeDecoration(
                      color: Color.fromRGBO(72, 62, 168, 1),
                      shape: CircleBorder(),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.fast_rewind_outlined),
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
                      onPressed: () {},
                      iconSize: 50,
                    ),
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
