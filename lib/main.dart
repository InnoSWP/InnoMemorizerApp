import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:memorizer/utils/sentences_parser.dart';
import 'package:memorizer/widgets/memorize.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:memorizer/widgets/paste_text.dart';
import 'package:memorizer/widgets/upload.dart';
import 'package:file_picker/file_picker.dart';

import 'package:pdf_text/pdf_text.dart';

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
        primaryColor: CustomColors.primary,
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
  PDFDoc? _pdfDoc;
  String? _pdfText;
  PlatformFile? _platformFile;
  bool _buttonEnabled = true;
  int _initialIndex = 0;
  Screen selectedScreen = Screen.pasteText;

  late AnimationController fileAnimationController;
  late AnimationController animationController;
  final textController = TextEditingController();

  Color color1 = Colors.white;
  Color color2 = CustomColors.primary;

  Future _pickPDF() async {
    var filePickerResult = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (filePickerResult != null) {
      _pdfDoc = await PDFDoc.fromPath(filePickerResult.files.single.path!);
      _platformFile = filePickerResult.files.first;
      setState(() {});
    }

    fileAnimationController.forward();
  }

  Future _fetchPDF() async {
    if (_pdfDoc == null) {
      return;
    }
    setState(() {
      _buttonEnabled = false;
    });
    String text = await _pdfDoc!.text;

    setState(() {
      _pdfText = text;
      _buttonEnabled = true;
    });
  }

  void _sendText() async {
    await _fetchPDF();
    var sentences = await fetchSentences(_pdfText!);
    setState(() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              MemorizeScreen(title: 'Memorize', sentences: sentences),
        ),
      );
    });
  }

  Widget getUploadScreen() {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(
            left: MediaQuery.of(context).size.width * 0.14,
            right: MediaQuery.of(context).size.width * 0.14,
            bottom: MediaQuery.of(context).size.height * 0.009,
          ),
          child: InkWell(
            onTap: _pickPDF,
            child: DottedBorder(
              borderType: BorderType.RRect,
              radius: const Radius.circular(4),
              dashPattern: const [10, 4],
              strokeCap: StrokeCap.round,
              //padding: EdgeInsets.all(6),
              color: const Color.fromRGBO(56, 78, 183, 0.3),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(4)),
                child: Container(
                    height: 250,
                    //width: 120,
                    color: const Color.fromRGBO(248, 248, 255, 1),
                    child: Center(
                        child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: EdgeInsets.only(
                              bottom:
                                  MediaQuery.of(context).size.height * 0.04),
                          child: const Image(
                              image: AssetImage('assets/images/upload.png')),
                        ),
                        Container(
                            padding: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).size.height * 0.015),
                            child: const Text(
                              'Browse files',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 22,
                                color: Color(0xFF483EA8),
                                decoration: TextDecoration.underline,
                              ),
                            )),
                        Container(
                          padding: EdgeInsets.only(
                              bottom:
                                  MediaQuery.of(context).size.height * 0.02),
                          child: const Text(
                            'Supported format: PDF',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 18,
                              color: Color.fromRGBO(0, 0, 0, 0.5),
                            ),
                          ),
                        )
                      ],
                    ))),
              ),
            ),
          ),
        ),
        _platformFile != null
            ? Container(
                padding: const EdgeInsets.all(30),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Uploading...',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            color: CustomColors.greyText,
                          )),
                      const SizedBox(
                        height: 15,
                      ),
                      TextField(
                        readOnly: true,
                        decoration: InputDecoration(
                          hintText: _platformFile!.name,
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.remove_circle_outlined),
                            color: const Color.fromRGBO(230, 230, 230, 1),
                            onPressed: () {
                              _platformFile = null;
                              _pdfDoc?.deleteFile();
                              fileAnimationController.stop();
                              fileAnimationController.reset();
                            },
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4.0),
                            borderSide: const BorderSide(
                              color: Color.fromRGBO(227, 227, 227, 1),
                              width: 1,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4.0),
                            borderSide: const BorderSide(
                              color: Color.fromRGBO(227, 227, 227, 1),
                              width: 1,
                            ),
                          ),
                        ),
                      ),
                      Container(
                          height: 2,
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: CustomColors.primary,
                          ),
                          child: LinearProgressIndicator(
                            value: fileAnimationController.value,
                            valueColor: const AlwaysStoppedAnimation<Color>(
                                CustomColors.primary),
                            backgroundColor: Colors.white,
                          )),
                    ]))
            : Container(),
        Padding(
          padding:
              EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.05),
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.06,
            child: ElevatedButton(
                onPressed: _buttonEnabled ? _sendText : null,
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                    (Set<MaterialState> states) {
                      if (states.contains(MaterialState.pressed)) {
                        return CustomColors.primary.withOpacity(0.5);
                      } else if (states.contains(MaterialState.disabled)) {
                        return CustomColors.primary.withOpacity(0.3);
                      }
                      return CustomColors.primary;
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
    );
  }

  Widget getCurrentScreen(context) {
    switch (selectedScreen) {
      case Screen.pasteText:
        return getPasteTextScreen(context, textController, animationController);
      case Screen.upload:
        return getUploadScreen();
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

    fileAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    )..addListener(() {
        setState(() {});
      });

    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    textController.dispose();
    fileAnimationController.dispose();
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
