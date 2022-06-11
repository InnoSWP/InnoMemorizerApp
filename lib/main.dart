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
      title: 'Upload',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        textTheme: GoogleFonts.mulishTextTheme(),
      ),
      home: const MyHomePage(title: 'Upload'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  int _initialIndex = 0;

  late AnimationController controller;

  Color color1 = Colors.white;
  Color color2 = const Color.fromRGBO(72, 62, 168, 1);

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..addListener(() {
        setState(() {});
      });
    controller.repeat(reverse: true);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(
              0,
              MediaQuery.of(context).size.width * 0.15,
              0,
              MediaQuery.of(context).size.width * 0.1,
            ),
            child: ToggleSwitch(
              minWidth: MediaQuery.of(context).size.width * 0.34,
              minHeight: MediaQuery.of(context).size.height * 0.04,
              cornerRadius: 40.0,
              customTextStyles: [
                TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 22,
                  color: color1,
                ),
                TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 22,
                  color: color2,
                ),
              ],
              activeBgColors: const [
                [Color.fromRGBO(72, 62, 168, 1)],
                [Color.fromRGBO(72, 62, 168, 1)]
              ],
              activeFgColor: Colors.white,
              fontSize: 22,
              inactiveBgColor: const Color.fromRGBO(247, 249, 251, 1),
              inactiveFgColor: const Color.fromRGBO(72, 62, 168, 1),
              initialLabelIndex: _initialIndex,
              totalSwitches: 2,
              borderColor: const [
                Color.fromRGBO(237, 239, 241, 1),
                Color.fromRGBO(237, 239, 241, 1)
              ],
              borderWidth: 0.5,
              labels: const ['Paste text', 'Upload'],
              radiusStyle: true,
              onToggle: (index) {
                setState(() {
                  _initialIndex = index!;
                  if (index == 1) {
                    color1 = const Color.fromRGBO(72, 62, 168, 1);
                    color2 = Colors.white;
                  } else if (index == 0) {
                    color1 = Colors.white;
                    color2 = const Color.fromRGBO(72, 62, 168, 1);
                  }
                });
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.14,
              bottom: MediaQuery.of(context).size.height * 0.009,
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: RichText(
                textAlign: TextAlign.left,
                text: const TextSpan(children: <TextSpan>[
                  TextSpan(
                    text: "Input text",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                      color: Color.fromRGBO(9, 16, 29, 0.8),
                    ),
                  ),
                  TextSpan(
                    text: "*",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                      color: Color.fromRGBO(225, 67, 67, 1),
                    ),
                  ),
                ]),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(
              MediaQuery.of(context).size.width * 0.12,
              0,
              MediaQuery.of(context).size.width * 0.12,
              MediaQuery.of(context).size.width * 0.15,
            ),
            child: SizedBox(
              height: 200,
              child: TextField(
                  maxLines: 10,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Color.fromRGBO(56, 78, 183, 1)),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Color.fromRGBO(72, 62, 168, 1)),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    hintText: 'Input your text here',
                    prefixText: ' ',
                  )),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.12,
              bottom: MediaQuery.of(context).size.height * 0.0236,
            ),
            child: const Align(
              alignment: Alignment.centerLeft,
              child: Text('Parsing...',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: Color.fromRGBO(103, 103, 103, 1),
                  )),
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(1000),
            child: SizedBox(
              width: 320,
              child: LinearProgressIndicator(
                minHeight: 22,
                backgroundColor: const Color.fromRGBO(190, 200, 236, 1),
                valueColor: const AlwaysStoppedAnimation<Color>(
                    Color.fromRGBO(72, 62, 168, 1)),
                value: controller.value,
                semanticsLabel: 'parsing indicator',
              ),
            ),
          ),
          const Text('76% completed',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Color.fromRGBO(72, 62, 168, 0.5),
              )),
          Padding(
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.06,
              child: ElevatedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed)) {
                          return const Color.fromRGBO(72, 62, 168, 0.5);
                        }
                        return const Color.fromRGBO(72, 62, 168, 1);
                      },
                    ),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                    ),
                  ),
                  child: const Text('START MEMORIZE',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                      ))),
            ),
          )
        ],
      ),
    );
  }
}
