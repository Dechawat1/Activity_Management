import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobileapp/style/app_style.dart';

import '../models/Note.dart';

class NoteReaderScreen extends StatefulWidget {
  const NoteReaderScreen({Key? key}) : super(key: key);

  @override
  State<NoteReaderScreen> createState() => _NoteReaderScreenState();
}

class _NoteReaderScreenState extends State<NoteReaderScreen> {
  List<Widget> widgets = [];
  List<NoteModel> model =  [];
  String? title,creation,content;
  num? color ;

  void readDatauserLogin() async {
    var firebaseUser = FirebaseAuth.instance.currentUser;
     await FirebaseFirestore.instance
        .collection("users")
        .doc(firebaseUser?.uid)
        .get()
        .then((value) {
      print(value.data());

      FirebaseFirestore.instance
          .collection("users")
          .doc(firebaseUser?.uid)
          .snapshots()
          .listen((value) {
        print('snapshot = ${value.id}');
        for (var snapshots in {value.id}) {
          FirebaseFirestore.instance
              .collection("users")
              .doc(value.id)
              .collection("Notes")
              .get()
              .then((subcol) {
            print(subcol.docs.length);
            subcol.docs.forEach((element) {
              print(element.id);
              Map<String, dynamic> map = element.data();
              print('map = $map');
              NoteModel model = NoteModel.fromMap(map);

              setState(() {
                title = model.note_title;
                creation = model.creation_data;
                content = model.note_content;
                color = model.color_id;
                print(color);

                // widgets.add(createWidger(model));
              });
            });
          });
        }
        ;
      });
    });
  }

  void readData() {
    var firebaseUser = FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance
        .collection("users")
        .doc(firebaseUser?.uid)
        .snapshots()
        .listen((value) {
      print('snapshot = ${value.id}');
      for (var snapshots in {value.id}) {
        FirebaseFirestore.instance
            .collection("users")
            .doc(value.id)
            .collection("Notes")
            .get()
            .then((value){
          print(value.docs.length);
          value.docs.forEach((element) {
            print(element.id);
            FirebaseFirestore.instance
            .collection("Notes")
            .doc(element.id)
            .get()
            .then((event) {
              print(event.reference);
            });
            Map<String, dynamic> map = element.data();
            print('map = $map');
          });
        });
      }

    });
  }

  Widget createWidger(NoteModel model) =>  ListView(
    shrinkWrap: true,
      children: [
        SizedBox(
          height: 100,
          width: 100,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                model.note_title,
                style: AppStyle.mainTitle,
              ),
              Text(
                model.creation_data,
                style: AppStyle.dateTitle,
              ),
              Text(
                model.note_content,
                style: AppStyle.mainContent,
              )
            ],
          ),
        )
      ]);



  @override
  void initState()  {
    readData();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyle.cardsColor[color!.toInt()],
      appBar: AppBar(
        backgroundColor: AppStyle.cardsColor[color!.toInt()],
        elevation: 0.0,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              title == null ? 'Title' : title!,
              style: AppStyle.mainTitle,
            ),
            SizedBox(height: 4,),
            Text(
              creation == null ? 'creation' : creation!,
              style: AppStyle.dateTitle,
            ),
            SizedBox(height: 28.0,),
            Text(
              content == null ? 'content' : content!,
              style: AppStyle.mainContent,
              overflow: TextOverflow.ellipsis,
            )
          ],
        ),
      ),
    );
  }
}
