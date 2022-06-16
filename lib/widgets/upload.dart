import 'package:flutter/cupertino.dart';

Widget getUploadScreen(context) {
  return Column(
    children: <Widget>[
      Padding(
        padding: EdgeInsets.only(
          left: MediaQuery.of(context).size.width * 0.14,
          bottom: MediaQuery.of(context).size.height * 0.009,
        ),
        child: const Align(
          alignment: Alignment.centerLeft,
          child: Text("123"),
        ),
      )
    ],
  );
}
