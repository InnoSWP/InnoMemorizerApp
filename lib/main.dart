import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toggle_switch/toggle_switch.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Memorize',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        textTheme: GoogleFonts.mulishTextTheme(),
      ),
      home: Scaffold(
        appBar: null,
        body: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(0, 70, 0, 15),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: IconButton(iconSize: 40,
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                      ),
                      onPressed: () {
                      },
                    ),
                  ),
                  Expanded(
                    /*1*/
                    child: const Text(
                      'All star song',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 28,
                        color: Color.fromRGBO(72, 62, 168, 1),
                      ),
                    ),
                  ),
                  /*3*/
                  Container(
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: IconButton(iconSize: 30,
                      icon: Icon(
                        Icons.settings,
                        color: Colors.black,
                      ),
                      onPressed: () {
                      },
                    ),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Color.fromRGBO(56, 78, 183, 1),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: <Widget>[


                    Container(
                      padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                            child: const Text(
                              '1',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 22,
                                color: Color.fromRGBO(0, 0, 0, 0.5),
                              ),
                            ),
                          ),
                          Flexible(
                            child: const Text(
                              'Somebody once told me the world is gonna roll me',
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 28,
                                  color: Color.fromRGBO(115, 129, 255, 1),
                                  fontFamily: 'RobotoMono'
                              ),
                            ),
                          )
                        ],
                      ),
                    ),


                    Container(
                      padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
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
                            child: const Text(
                              'I ain\'t the sharpest tool in the shed',
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 36,
                                  color: Color.fromRGBO(34, 56, 255, 1),
                                  fontFamily: 'RobotoMono'
                              ),
                            ),
                          )
                        ],
                      ),
                    ),


                    Container(
                      padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                            child: const Text(
                              '3',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 22,
                                color: Color.fromRGBO(0, 0, 0, 0.5),
                              ),
                            ),
                          ),
                          Flexible(
                            child: const Text(
                              'She was looking kind of dumb with her finger and her thumb',
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 28,
                                  color: Color.fromRGBO(115, 129, 255, 1),
                                  fontFamily: 'RobotoMono'
                              ),
                            ),
                          )
                        ],
                      ),
                    ),



                    Container(
                      padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                              child: const Text(
                                '2/306 complete',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 24,
                                  color: Color.fromRGBO(0, 0, 0, 0.5),
                                ),
                              ),
                            )
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(0, 0, 10, 10),
                            child: Column(
                              children: [
                                Container(
                                  child: IconButton(iconSize: 40,
                                    icon: Icon(
                                      Icons.refresh,
                                      color: Colors.black,
                                    ),
                                    onPressed: () {
                                    },
                                  ),
                                ),
                                Container(
                                  child: const Text(
                                    'Repeat',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 22,
                                      color: Color.fromRGBO(0, 0, 0, 0.5),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          )
                        ],
                      ),
                    ),



                  ],
                ),
              ),
            ),


            Container(
              padding: EdgeInsets.fromLTRB(100, 50, 0, 0),
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
              )
            )
          ],
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
