import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobileapp/Widget/add_schdule.dart';

import '../models/schdules.dart';
import 'assignmentWidet/constants.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({Key? key}) : super(key: key);

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  final user = FirebaseAuth.instance.currentUser!;
  List<Widget> widgets = [];
  String? uid = FirebaseAuth.instance.currentUser!.uid;
  var firebaseUser = FirebaseAuth.instance.currentUser;
  CollectionReference? schduleRef;



  @override
  void initState() {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    schduleRef = FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('schedules');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(79, 109, 166, 1),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromRGBO(79, 109, 166, 1),
        centerTitle: true,
        title: Text(
          'Class Schedul',
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20),
        ),
      ),
      body: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  height: 50,
                  width: 450,
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            alignment: Alignment.topLeft,
                            height: 60,
                            width: 60,
                            child: Image.asset('assets/schedule 1.png'),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text('List Schedule',style: TextStyle(fontSize: 17,fontWeight: FontWeight.w500),),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
                stream: schduleRef!.snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: Text('No Tasks Yet'),
                      );
                    } else {
                      return Container(
                        decoration: BoxDecoration(
                          color:  Color.fromRGBO(79, 109, 166, 1),
                          borderRadius: kTopBorderRadius,
                        ),
                        child: ListView.builder(
                            padding: EdgeInsets.all(kDefaultPadding),
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              return Container(
                                margin:
                                EdgeInsets.only(bottom: kDefaultPadding),
                                child: SingleChildScrollView(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                          padding: EdgeInsets.all(8),
                                           margin: EdgeInsets.all(16),
                                          decoration: BoxDecoration(
                                              color: Colors.white, borderRadius: BorderRadius.circular(kDefaultPadding), boxShadow: [
                                                BoxShadow(
                                                   // color: kTextLightColor,
                                                      color: Colors.blue.shade400,
                                                       blurRadius: 5.0,)]),
                                          child: Column(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              children: <Widget>[
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                        margin: EdgeInsets.all(10),
                                                        child: Text(snapshot.data!.docs[index]
                                                        ['subject'],style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold
                                                        ))
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Container(
                                                        margin: EdgeInsets.all(10),
                                                        child: Text("Section :  " + snapshot.data!.docs[index]
                                                        ['room'],style: TextStyle(fontSize: 17,fontWeight: FontWeight.w500),)),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Container(
                                                        margin: EdgeInsets.all(10),
                                                        child: Text("Time :  " + snapshot.data!.docs[index]
                                                        ['time'],style: TextStyle(fontSize: 17,fontWeight: FontWeight.w500)))
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Container(
                                                        margin: EdgeInsets.all(10),
                                                        child: Text("Day :  " + snapshot.data!.docs[index]
                                                        ['day'],style: TextStyle(fontSize: 17,fontWeight: FontWeight.w500)))
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                  children: [
                                                    TextButton.icon(
                                                        style: TextButton.styleFrom(
                                                            foregroundColor: Colors.white,
                                                            backgroundColor: Colors.orange),
                                                        onPressed: () async{
                                                          AwesomeDialog(
                                                            context: context,
                                                            dialogType: DialogType.warning,
                                                            animType: AnimType.scale,
                                                            showCloseIcon: true,
                                                            title: "Warning",
                                                            desc: "คุณต้องการลบตารางเรียน ? ",
                                                            descTextStyle:
                                                            const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                                            btnOkOnPress: () async {
                                                              if (schduleRef!= null) {
                                                                await schduleRef!
                                                                    .doc(
                                                                    '${snapshot.data!.docs[index]['ScheduleId']}')
                                                                    .delete();
                                                              }
                                                            },
                                                            btnCancelOnPress: () {
                                                              Navigator.push(context, MaterialPageRoute(builder: (context)=> ScheduleScreen()));
                                                            },
                                                          ).show();
                                                        },
                                                        icon: const Icon(Icons.delete_forever),
                                                        label: const Text('Delete'))
                                                  ],
                                                )
                                              ]
                                          )),
                                    ],
                                  ),
                                ),
                              );
                            }),
                      );
                    }
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueAccent.shade100,
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>AddSchedule()));
        },
        child: Icon(Icons.add,color: Colors.white,),

      ),
    );
  }
  Container buildTextInfoHomework() {
    return Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: Colors.white70, borderRadius: BorderRadius.circular(15)),
        child: Column(
          children: <Widget>[
            Text("Subject : "),
            Text("Submit work : "),
            Text("Detail : ")
          ],
        ));
  }
}
