import 'package:flutter/material.dart';

import '/../utils/sentences_parser.dart';
import '/../common/theme.dart';

import 'memorize.dart';

class TypeScreen extends StatefulWidget {
  const TypeScreen({Key? key}) : super(key: key);

  @override
  State<TypeScreen> createState() => Type();
}

class Type extends State<TypeScreen> with TickerProviderStateMixin {
  late AnimationController animationController;
  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Stack(
        alignment: Alignment.center,
        fit: StackFit.loose,
        children: <Widget>[
          Positioned(
            top: MediaQuery.of(context).size.height * 0.02,
            left: MediaQuery.of(context).size.width * 0.14,
            child: Align(
              alignment: Alignment.centerLeft,
              child: RichText(
                textAlign: TextAlign.left,
                text: const TextSpan(children: <TextSpan>[
                  TextSpan(
                    text: "Input text",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 26,
                      color: CustomColors.blackText,
                    ),
                  ),
                  TextSpan(
                    text: "*",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 26,
                      color: CustomColors.error,
                    ),
                  ),
                ]),
              ),
            ),
          ),
          Positioned(
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                MediaQuery.of(context).size.width * 0.1,
                MediaQuery.of(context).size.height * 0.07,
                MediaQuery.of(context).size.width * 0.1,
                MediaQuery.of(context).size.height * 0.33,
              ),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.4,
                width: MediaQuery.of(context).size.width * 0.8,
                child: TextField(
                  controller: textController,
                  maxLines: 32,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: CustomColors.blueBorder),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: CustomColors.darkBlueBorder),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    hintText: 'Type or paste your text here...',
                    prefixText: ' ',
                  ),
                  style: const TextStyle(fontSize: 22),
                ),
              ),
            ),
          ),
          Visibility(
              maintainSize: true,
              maintainAnimation: true,
              maintainState: true,
              visible: animationController.value != 0.0,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.35,
                      left: MediaQuery.of(context).size.width * 0.12,
                      bottom: MediaQuery.of(context).size.height * 0.0236,
                    ),
                    child: const Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Parsing...',
                          style: TextStyle(
                            fontSize: 27,
                            fontWeight: FontWeight.w700,
                            color: CustomColors.greyText,
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
                            CustomColors.primary),
                        value: animationController.value,
                        semanticsLabel: 'parsing indicator',
                      ),
                    ),
                  ),
                  Text(
                      "${(animationController.value * 100).round()}% completed",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                        color: CustomColors.primary.withOpacity(0.5),
                      )),
                ],
              )),
          AnimatedPositioned(
            bottom: MediaQuery.of(context).viewInsets.bottom * 0.9,
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.06,
            duration: const Duration(milliseconds: 150),
            child: ValueListenableBuilder<TextEditingValue>(
              valueListenable: textController,
              builder: (context, value, child) {
                return ElevatedButton(
                    onPressed: value.text.isNotEmpty
                        ? () {
                            FocusManager.instance.primaryFocus?.unfocus();
                            animationController.forward();
                            fetchSentences(value.text).then((sentences) {
                              animationController.fling();
                              animationController.reset();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MemorizeScreen(
                                      title: 'Memorize', sentences: sentences),
                                ),
                              );
                            });
                          }
                        : null,
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.resolveWith<Color?>(
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
                        )));
              },
            ),
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..addListener(() {
        setState(() {});
      });

    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    textController.dispose();
    super.dispose();
  }
}
