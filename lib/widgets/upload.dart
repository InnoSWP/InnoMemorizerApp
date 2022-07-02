import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:pdf_text/pdf_text.dart';

import '/../utils/sentences_parser.dart';
import '/../common/theme.dart';

import 'memorize.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({Key? key}) : super(key: key);

  @override
  State<UploadScreen> createState() => Upload();
}

class Upload extends State<UploadScreen> with TickerProviderStateMixin {
  PDFDoc? _pdfDoc;
  PlatformFile? _platformFile;
  bool _buttonEnabled = false;

  List<String> _sentences = [];

  late AnimationController fileAnimationController;

  @override
  void initState() {
    fileAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 12),
    )..addListener(() {
        setState(() {});
      });

    super.initState();
  }

  @override
  void dispose() {
    fileAnimationController.dispose();
    super.dispose();
  }

  void clearUploadedFile() {
    setState(() {
      _buttonEnabled = false;
      _platformFile = null;
      _pdfDoc?.deleteFile();
      fileAnimationController.stop();
      fileAnimationController.reset();
    });
  }

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
    _fetchPDF();
  }

  Future _fetchPDF() async {
    if (_pdfDoc == null) {
      return;
    }
    setState(() {
      _buttonEnabled = false;
    });
    String text = await _pdfDoc!.text;

    fetchSentences(text).then((sentences) {
      setState(() {
        _sentences = sentences;
        fileAnimationController.fling();
        _buttonEnabled = true;
      });
    });
  }

  void _sendText() async {
    setState(() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              MemorizeScreen(title: 'Memorize', sentences: _sentences),
        ),
      );
      clearUploadedFile();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Positioned(
          width: MediaQuery.of(context).size.width,
          top: MediaQuery.of(context).size.height * 0.035,
          child: Padding(
            padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.1,
              right: MediaQuery.of(context).size.width * 0.1,
              bottom: MediaQuery.of(context).size.height * 0.05,
            ),
            child: InkWell(
              onTap: _pickPDF,
              child: DottedBorder(
                borderType: BorderType.RRect,
                radius: const Radius.circular(4),
                dashPattern: const [10, 4],
                strokeCap: StrokeCap.round,
                color: const Color.fromRGBO(56, 78, 183, 0.3),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(4)),
                  child: Container(
                      height: MediaQuery.of(context).size.height * 0.4255,
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
                                  bottom: MediaQuery.of(context).size.height *
                                      0.015),
                              child: const Text(
                                'Browse files',
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 24,
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
                                fontSize: 20,
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
        ),
        _platformFile != null
            ? Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.52),
                child: Container(
                    padding: const EdgeInsets.only(left: 30, right: 30),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Uploading...',
                              style: TextStyle(
                                fontSize: 24,
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
                                  clearUploadedFile();
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
                        ])),
              )
            : Container(),
        Positioned(
          bottom: MediaQuery.of(context).size.height * 0.05,
          child: Padding(
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.07),
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
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ))),
            ),
          ),
        )
      ],
    );
  }
}
