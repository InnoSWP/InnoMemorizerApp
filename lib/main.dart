import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '/widgets/upload.dart';
import '/widgets/paste_text.dart';

import 'common/theme.dart';

void main() {
  runApp(const MemorizationApp());
}

class MemorizationApp extends StatelessWidget {
  const MemorizationApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SharedPreferences.getInstance()
        .then((prefs) => prefs.setInt('numberOfRepetitions', 1));

    return MaterialApp(
      theme: ThemeData(
        primaryColor: CustomColors.primary,
        scaffoldBackgroundColor: Colors.white,
        textTheme: GoogleFonts.mulishTextTheme(),
      ),
      home: const MainPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => MainPageState();
}

class MainPageState extends State<MainPage> with TickerProviderStateMixin {
  int _currentIndex = 0;

  Color color1 = Colors.white;
  Color color2 = CustomColors.primary;

  final uploadScreen = const UploadScreen();
  final typeScreen = const TypeScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: IndexedStack(
        index: _currentIndex,
        children: <Widget>[
          getScreen(typeScreen),
          getScreen(uploadScreen),
        ],
      ),
    );
  }

  Widget getScreen(StatefulWidget screen) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        getTopBar(context),
        Positioned(
            bottom: 0,
            child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.85,
                child: screen)),
      ],
    );
  }

  Widget getTopBar(context) {
    return Positioned(
      top: MediaQuery.of(context).size.height * 0.075,
      child: ToggleSwitch(
        minWidth: MediaQuery.of(context).size.width * 0.34,
        minHeight: MediaQuery.of(context).size.height * 0.045,
        cornerRadius: 40.0,
        customTextStyles: [
          TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 24,
            color: color1,
          ),
          TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 24,
            color: color2,
          ),
        ],
        activeBgColors: const [
          [CustomColors.primary],
          [CustomColors.primary]
        ],
        activeFgColor: Colors.white,
        fontSize: 24,
        inactiveBgColor: CustomColors.background,
        inactiveFgColor: CustomColors.primary,
        initialLabelIndex: _currentIndex,
        totalSwitches: 2,
        borderColor: const [CustomColors.whiteBorder, CustomColors.whiteBorder],
        borderWidth: 0.5,
        labels: const ['Type', 'Upload'],
        radiusStyle: true,
        onToggle: (index) {
          setState(() {
            _currentIndex = index!;
            if (index == 0) {
              color1 = Colors.white;
              color2 = CustomColors.primary;
            } else if (index == 1) {
              color1 = CustomColors.primary;
              color2 = Colors.white;
            }
          });
        },
      ),
    );
  }
}
