import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:dotted_border/dotted_border.dart';

Widget getUploadScreen(context) {
  return Column(
    children: <Widget>[
      Padding(
        padding: EdgeInsets.only(
          left: MediaQuery.of(context).size.width * 0.14,
          right: MediaQuery.of(context).size.width * 0.14,
          bottom: MediaQuery.of(context).size.height * 0.009,
        ),
        child: DottedBorder(
          borderType: BorderType.RRect,
          radius: Radius.circular(4),
          //padding: EdgeInsets.all(6),
          color: Color.fromRGBO(56, 78, 183, 0.3),
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            child: Container(
              height: 250,
              //width: 120,
              color: Color.fromRGBO(248, 248, 255, 1),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).size.height * 0.04
                      ),
                      child: Image(
                          image: AssetImage('assets/images/upload-icon2.png')
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).size.height * 0.015
                      ),
                      child: const Text(
                        'Browse files',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 22,
                          color: Color(0xFF483EA8),
                          decoration: TextDecoration.underline,
                        ),
                      )
                    ),
                    Container(
                      padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).size.height * 0.02
                      ),
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
                )
              )
            ),
          ),
        ),
      )
    ],
  );
}
