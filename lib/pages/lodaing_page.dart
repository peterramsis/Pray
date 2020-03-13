import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:qrscan/qrscan.dart' as scanner;

class LoadingPage extends StatefulWidget {
  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Timer(Duration(
      seconds: 3
    ), (){
      Navigator.of(context).pushNamed("/home");
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF2f3640),
      body: Center(
        child: Container(
          child:  Column(
           mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.asset("images/home.png",
                height: 300,
                alignment: Alignment.center,),
              Text("Attendance Pray",style: TextStyle(
                  fontSize: 25,
                  color: Color(0xFFf5f6fa)
              ),),
              SpinKitWave(
                color: Colors.white,
                size: 50.0,
              )
            ],
          ),
        ),
      ),
    );
  }
}
