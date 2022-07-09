import 'package:flutter/material.dart';
import '/widgets/info_page.dart';

class Info extends StatelessWidget{
  const Info({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      home: InfoPage(),
    );
  }
}