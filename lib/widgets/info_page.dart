import 'package:flutter/material.dart';

class InfoPage extends StatelessWidget{
  const InfoPage();

  @override
  Widget build(BuildContext context){
    return Scaffold(
        appBar: AppBar(
          title: Center(child: Text('List of voice commands')),
          backgroundColor: Color.fromRGBO(72, 62, 168, 1),
        ),
        body: Column(
          children: [
            SizedBox(
              height: 75,
              width: double.infinity,
            ),
            Container(
              width: double.infinity,
              height: 75,
              child: Text('To trigger Allan voice assistant say: Hey, Allan'),
            ),
            Container(
              width: double.infinity,
              height: 75,
              child: Text('To start memorizing process say: Play'),
            ),
            Container(
              width: double.infinity,
              height: 75,
              child: Text('To return to the previous sentence say: Back'),
            ),
            Container(
              width: double.infinity,
              height: 75,
              child: Text('To move to the next sentence say: Forward'),
            ),
            Container(
              width: double.infinity,
              height: 75,
              child: Text('To stop memorizing process say: Stop'),
            )
          ],
        )
    );
  }
}