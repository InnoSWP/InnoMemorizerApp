import 'package:flutter/material.dart';

class Info extends StatelessWidget{
  const Info();

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
           // title: Center(child: Text('List of voice commands')),
            centerTitle: true,
            title: Text('List of voice commands'),
            backgroundColor: Color.fromRGBO(72, 62, 168, 1),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_rounded,
              color: Colors.white,
              ),
              onPressed: () {},
            ),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: double.infinity,
                height: 50,
                child: Text('To trigger Allan voice assistant say: "Hey, Allan"',
                style: TextStyle(
                  fontSize: 19,
                ) ,
                textAlign: TextAlign.center,),
              ),
              Container(
                width: double.infinity,
                height: 50,
                child: Text('To start memorizing process say: "Play"',
                style: TextStyle(
                  fontSize: 21
                ),textAlign: TextAlign.center,),
              ),
              Container(
                width: double.infinity,
                height: 50,
                child: Text('To return to the previous sentence say: "Back"',
                style: TextStyle(
                  fontSize: 20
                ), textAlign: TextAlign.center,),
              ),
              Container(
                width: double.infinity,
                height: 50,
                child: Text('To move to the next sentence say: "Forward"',
                style: TextStyle(
                  fontSize: 20
                ),textAlign: TextAlign.center,),
              ),
              Container(
                width: double.infinity,
                height: 50,
                child: Text('To stop memorizing process say: "Stop"',
                style: TextStyle(
                  fontSize: 22
                ),textAlign: TextAlign.center,),
              )
            ],
          )
      ),
    );
  }
}