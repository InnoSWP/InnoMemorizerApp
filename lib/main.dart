import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:memorizer/widgets/paste_text.dart';
import 'package:memorizer/widgets/upload.dart';

import 'common/theme.dart';

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

enum Screen { pasteText, upload }

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  int _initialIndex = 0;
  Screen selectedScreen = Screen.pasteText;

  late AnimationController animationController;
  final textController = TextEditingController();

  Color color1 = Colors.white;
  Color color2 = CustomColors.primary;

  Widget getCurrentScreen(context) {
    switch (selectedScreen) {
      case Screen.pasteText:
        return getPasteTextScreen(context, textController, animationController);
      case Screen.upload:
        return getUploadScreen(context);
    }
  }

  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..addListener(() {
        setState(() {});
      });
    animationController.repeat(reverse: true);
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    textController.dispose();
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
                [CustomColors.primary],
                [CustomColors.primary]
              ],
              activeFgColor: Colors.white,
              fontSize: 22,
              inactiveBgColor: CustomColors.background,
              inactiveFgColor: CustomColors.primary,
              initialLabelIndex: _initialIndex,
              totalSwitches: 2,
              borderColor: const [
                CustomColors.whiteBorder,
                CustomColors.whiteBorder
              ],
              borderWidth: 0.5,
              labels: const ['Paste text', 'Upload'],
              radiusStyle: true,
              onToggle: (index) {
                setState(() {
                  _initialIndex = index!;
                  if (index == 0) {
                    selectedScreen = Screen.pasteText;
                    color1 = Colors.white;
                    color2 = CustomColors.primary;
                  } else if (index == 1) {
                    selectedScreen = Screen.upload;
                    color1 = CustomColors.primary;
                    color2 = Colors.white;
                  }
                });
              },
            ),
          ),
          getCurrentScreen(context),
        ],
      ),
    );
  }
}
