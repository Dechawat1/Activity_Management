import 'dart:async';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mobileapp/Login.dart';

class SplashScreen extends StatefulWidget {

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 5),
            () =>
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder:
                    (context) =>
                const LoginPage()
                )
            )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[900],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Container(
            height: 40,
          ),
          Container(
            alignment: Alignment.topCenter,
            height: 240,
            child: Image(image: AssetImage('assets/1.jpg'),),
          ),
          SizedBox(height: 60,),
          Container(
            margin: EdgeInsets.all(10),
            child: Text('You can’t keep it',style: TextStyle(fontSize: 40,color: Colors.white,fontFamily: 'GreatVibes')),
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: Text('But',style: TextStyle(fontSize: 40,color: Colors.white,fontFamily: 'GreatVibes')),
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: Text('You can manage it !',style: TextStyle(fontSize: 40,color: Colors.white,fontFamily: 'GreatVibes')),
          ),
          SizedBox(height: 80,),
          Text('Welcome To Activity Manament',style: TextStyle(fontSize: 15,color: Colors.white,),)
        ],
      ),
    );
  }
}