import 'package:flutter/material.dart';
import 'package:memorizer/widgets/memorize.dart';

import '/../utils/sentences_parser.dart';
import '/../common/theme.dart';

Widget getPasteTextScreen(context, textController, animationController) {
  return SingleChildScrollView(
    child: Column(
      children: <Widget>[
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
                    color: CustomColors.blackText,
                  ),
                ),
                TextSpan(
                  text: "*",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                    color: CustomColors.error,
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
                controller: textController,
                maxLines: 10,
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
                  hintText: 'Input your text here',
                  prefixText: ' ',
                )),
          ),
        ),
        animationController.value == 0.0
            ? const SizedBox(
                height: 10,
              )
            : Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.12,
                      bottom: MediaQuery.of(context).size.height * 0.0236,
                    ),
                    child: const Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Parsing..',
                          style: TextStyle(
                            fontSize: 22,
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
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: CustomColors.primary.withOpacity(0.5),
                      )),
                ],
              ),
        Padding(
          padding:
              EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.06,
            child: ElevatedButton(
                onPressed: textController.text.isNotEmpty
                    ? () {
                        animationController.forward();
                        fetchSentences(textController.text).then((sentences) {
                          while (animationController.status !=
                              AnimationStatus.completed) {
                            animationController.value += 0.01;
                            Future.delayed(const Duration(milliseconds: 300));
                          }
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
    ),
  );
}
