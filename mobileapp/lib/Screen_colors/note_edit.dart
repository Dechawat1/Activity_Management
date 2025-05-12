import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../style/app_style.dart';

class NoteEditorScreen extends StatefulWidget {
  const NoteEditorScreen({Key? key}) : super(key: key);

  @override
  State<NoteEditorScreen> createState() => _NoteEditorScreenState();
}

class _NoteEditorScreenState extends State<NoteEditorScreen> {
  var firebaseUser = FirebaseAuth.instance.currentUser;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _mainController = TextEditingController();
  String data = DateTime.now().toString();

  int color_id = Random().nextInt(AppStyle.cardsColor.length);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyle.cardsColor[color_id],
      appBar: AppBar(
        backgroundColor: AppStyle.cardsColor[color_id],
        elevation: 0.0,
        title: Text("Add a new Note"),

      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _titleController,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Note Title'
              ),
              style: AppStyle.mainTitle,
            ),
            SizedBox(height: 8.0,),
            Text(data,style: AppStyle.dateTitle,),
            SizedBox(height: 28,),
            TextFormField(
              controller: _mainController,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Note content'
              ),
              style: AppStyle.mainContent,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppStyle.accentColor,
        onPressed: () async {
          User? user = FirebaseAuth.instance.currentUser;
          if( user != null ){
            String uid = user.uid;
            int dt = DateTime.now().millisecondsSinceEpoch;
            FirebaseFirestore firestore = FirebaseFirestore.instance;
            var notesRef = firestore.collection('users').doc(uid).collection('Notes').doc();
            await notesRef.set({
              "note_title": _titleController.text,
              "note_content": _mainController.text,
              "creation_data": dt,
              "color_id": color_id,
              'NotesId': notesRef.id,
            });
            Fluttertoast.showToast(msg: 'Notes Added');
            Navigator.of(context).pop();
          }
          // setState(() {
          //   FirebaseFirestore.instance
          //       .collection("users")
          //       .doc(firebaseUser?.uid)
          //       .snapshots()
          //       .listen((value) {
          //     for (var snapshots in {value.id}) {
          //       FirebaseFirestore.instance
          //           .collection("users")
          //           .doc(value.id)
          //           .collection("Notes")
          //           .add({
          //         "note_title": _titleController.text,
          //         "note_content": _mainController.text,
          //         "creation_data": data,
          //         "color_id": color_id
          //       }).then((DocumentReference doc) {
          //         print(doc.id);
          //         Navigator.pop(context);
          //       }).catchError((error) => print("Faild to new note $error"));
          //     }
          //   });
          // });

        },
        child: Icon(Icons.save_as_sharp),
      ),
    );
  }
}
