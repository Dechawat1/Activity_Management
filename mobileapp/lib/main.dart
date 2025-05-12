import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mobileapp/Clock.dart';
import 'package:mobileapp/HomeScreen.dart';
import 'package:mobileapp/Login.dart';
import 'package:mobileapp/Screen/Schedule.dart';
import 'package:mobileapp/page_Main.dart';

import 'Homeworktest.dart';
import 'Screen/Profile.dart';
import 'SplashScreen.dart';
import 'mainscreen.dart';




Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Animation',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),

      home: FirebaseAuth.instance.currentUser == null
           ? SplashScreen()
           : const MainScreen(),
    );
  }
}
