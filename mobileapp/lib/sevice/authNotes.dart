import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobileapp/models/Note.dart';

import '../style/app_style.dart';

class AuthServiceNotes {
  final auth = FirebaseAuth.instance;
  var firebaseUser = FirebaseAuth.instance.currentUser;
  TextEditingController _titleController = TextEditingController();
  TextEditingController _mainController = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  String data = DateTime.now().toString();

  int color_id = Random().nextInt(AppStyle.cardsColor.length);

  final firestore = FirebaseFirestore.instance;
  Stream<User?> get authStateChanges => auth.idTokenChanges();

  void loginUser(context) async {
    try {
      showDialog(
          context: context,
          builder: (context) {
            return const AlertDialog(
              title: Center(
                child: CircularProgressIndicator(),
              ),
            );
          });
      await auth
          .signInWithEmailAndPassword(
          email: email.text, password: password.text)
          .then((value) => {
        Navigator.pop(context),
      });
    } catch (e) {
      print(e);
    }
  }

  void addNotes(context) async {
    try {
      await auth
          .createUserWithEmailAndPassword(
          email: email.text, password: password.text)
          .then((value) async {
        User? user = FirebaseAuth.instance.currentUser;
        print("Notes Is Registered");

        NoteModel model = NoteModel(
            color_id: color_id,
            creation_data: DateTime.now().toString(),
            note_content: _mainController.text,
            note_title: _titleController.text,
            uid : user?.uid
        );
        Map<String, dynamic> data = model.toMap();
        await FirebaseFirestore.instance
            .collection("notes")
            .doc(user?.uid)
            .set(data)
            .then((value) => print('สำเร็จ'));
        return print("notes is add");
        /* Navigator.push(
            context, MaterialPageRoute(builder: (context) => Login())); */
      });
    } catch (e) {
      print(e);
    }
  }
}