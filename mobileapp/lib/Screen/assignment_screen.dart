import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobileapp/Widget/add_assignment.dart';
import '../models/assignmentModel.dart';

import '../style/app_style.dart';
import 'assignmentWidet/constants.dart';

class AssignmentScreen extends StatefulWidget {
  const AssignmentScreen({Key? key}) : super(key: key);

  @override
  State<AssignmentScreen> createState() => _AssignmentScreenState();
}

class _AssignmentScreenState extends State<AssignmentScreen> {
  int? assignDate1;
  String? uid = FirebaseAuth.instance.currentUser!.uid;
  var firebaseUser = FirebaseAuth.instance.currentUser;
  CollectionReference? assignmentRef;
  String? status;
  int? color = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    String uid = FirebaseAuth.instance.currentUser!.uid;
    assignmentRef = FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('Assignment');
    print(assignmentRef?.parent);
    readitemAssignment();
  }

  Future<void> readitemAssignment() async {
    var firebaseUser = FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance
        .collection("users")
        .doc(firebaseUser?.uid)
        .get()
        .then((value) {
      FirebaseFirestore.instance
          .collection("users")
          .doc(firebaseUser?.uid)
          .snapshots()
          .listen((value) {
        for (var snapshots in {value.id}) {
          FirebaseFirestore.instance
              .collection("users")
              .doc(value.id)
              .collection("Assignment")
              .get()
              .then((subcol) {
            subcol.docs.forEach((element) {
              Map<String, dynamic> map = element.data();
              AssignmentData model = AssignmentData.fromMap(map);
              setState(() {
                status = model.status;


            });
            });
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(79, 109, 166, 1),

      appBar: AppBar(
        automaticallyImplyLeading: false,
        shadowColor: Colors.blueAccent.shade700,
        backgroundColor: Color.fromRGBO(79, 109, 166, 1),
        centerTitle: true,
        title: Text('Assignments',style: TextStyle(color: Colors.white),),
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
                            child: Image.asset('assets/homework.png'),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text('List Assignment',style: TextStyle(fontSize: 17,fontWeight: FontWeight.w500),),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
                stream: assignmentRef!.snapshots(),
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
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(kDefaultPadding),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            kDefaultPadding),
                                        color: kOtherColor,
                                        boxShadow: [
                                          BoxShadow(
                                            // color: kTextLightColor,
                                            color: Colors.blue.shade400,
                                            blurRadius: 5.0,
                                          ),
                                        ],
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Center(
                                            child: Container(
                                              width: 100,
                                              height: 50,
                                              decoration: BoxDecoration(
                                                color: Colors.blue.shade300
                                                    .withOpacity(0.7),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        kDefaultPadding),

                                              ),
                                              child: Center(
                                                child: Text(
                                                  snapshot.data!.docs[index]
                                                      ['subjectName'],
                                                  style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),
                                                ),
                                              ),
                                            ),
                                          ),
                                          kHalfSizedBox,
                                          Text('Topic  :    ' +
                                            snapshot.data!.docs[index]
                                                ['topicName'],
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle2!
                                                .copyWith(
                                                  color: kTextBlackColor,
                                                  fontWeight: FontWeight.w900,
                                                ),
                                          ),
                                          kHalfSizedBox,
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Assign Date',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .caption!
                                                    .copyWith(
                                                        color: kTextBlackColor,
                                                        fontWeight:
                                                            FontWeight.w900),
                                              ),
                                              Text(
                                                formattedDate(snapshot.data!
                                                    .docs[index]['assignDate']),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .caption!.copyWith(fontWeight: FontWeight.w600,color: Colors.black),
                                              ),
                                            ],
                                          ),

                                          kHalfSizedBox,
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Last Date',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .caption!
                                                    .copyWith(
                                                        color: kTextBlackColor,
                                                        fontWeight:
                                                            FontWeight.w900),
                                              ),
                                              Text(
                                                formattedDate(snapshot.data!
                                                    .docs[index]['lastDate']),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .caption!.copyWith(fontWeight: FontWeight.w600,color: Colors.black),
                                              ),
                                            ],
                                          ),

                                          kHalfSizedBox,
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Status',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .caption!
                                                    .copyWith(
                                                        color: kTextBlackColor,
                                                        fontWeight:
                                                            FontWeight.w900),
                                              ),
                                              Text(
                                                snapshot.data!.docs[index]
                                                    ['status'],
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .caption!.copyWith(fontWeight: FontWeight.w600,color: AppStyle.textColor[snapshot.data!.docs[index]['color']],
                                              ),
                                              ),
                                            ],
                                          ),
                                          kHalfSizedBox,
                                          //use condition here to display button
                                          if (snapshot.data!.docs[index]
                                                  ['status'] ==  'Pending')

                                            //then show button
                                            GestureDetector(
                                              onTap: () async {
                                                if (assignmentRef != null) {
                                                  await assignmentRef!
                                                      .doc(
                                                      '${snapshot.data!.docs[index]['AssignmentId']}')
                                                      .update({
                                                    'status' : 'Submitted',
                                                    'color' : color,
                                                  });
                                                }
                                              },
                                              child: Container(
                                                width: 320,
                                                height: 50,
                                                decoration: BoxDecoration(
                                                  gradient: LinearGradient(
                                                    colors: [
                                                      kSecondaryColor,
                                                      kPrimaryColor
                                                    ],
                                                    begin:
                                                        const FractionalOffset(
                                                            0.0, 0.0),
                                                    end: const FractionalOffset(
                                                        0.5, 0.0),
                                                    stops: [0.0, 1.0],
                                                    tileMode: TileMode.clamp,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          kDefaultPadding),
                                                ),
                                                child: Center(
                                                  child: Text('To be Submitted',
                                                      style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white) ),
                                                ),
                                              ),
                                            ),




                                          if (snapshot.data!.docs[index]
                                          ['status'] ==  'Submitted')

                                          //then show button
                                            GestureDetector(
                                              onTap: () async {
                                                  AwesomeDialog(
                                                    context: context,
                                                    dialogType: DialogType.warning,
                                                    animType: AnimType.scale,
                                                    showCloseIcon: true,
                                                    title: "Warning",
                                                    desc: "คุณต้องการลบ Assignment ? ",
                                                    descTextStyle:
                                                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                                    btnOkOnPress: () async {
                                                      if (assignmentRef!= null) {
                                                        await assignmentRef!
                                                            .doc(
                                                            '${snapshot.data!.docs[index]['AssignmentId']}')
                                                            .delete();
                                                      }
                                                    },
                                                    btnCancelOnPress: () {
                                                      Navigator.push(context, MaterialPageRoute(builder: (context)=> AssignmentScreen()));
                                                    },
                                                  ).show();
                                              },
                                              child: Container(
                                                width: 320,
                                                height: 50,
                                                decoration: BoxDecoration(
                                                  gradient: LinearGradient(
                                                    colors: [
                                                     Color(0xFFff4667),
                                                      Color(0xFFE53935)
                                                    ],
                                                    begin:
                                                    const FractionalOffset(
                                                        0.0, 0.0),
                                                    end: const FractionalOffset(
                                                        0.5, 0.0),
                                                    stops: [0.0, 1.0],
                                                    tileMode: TileMode.clamp,
                                                  ),
                                                  borderRadius:
                                                  BorderRadius.circular(
                                                      kDefaultPadding),
                                                ),
                                                child: Center(
                                                  child: Text('Delete',
                                                      style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white) ),
                                                ),
                                              ),
                                            ),


                                        ],
                                      ),
                                    ),
                                  ],
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
        backgroundColor: Colors.blue.shade300,
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddAssignment()));
        },
        child: Icon(Icons.add,color: Colors.white,),
      ),
    );
  }

  String formattedDate(timeStamp) {
    var dateFromTimeStamp =
        DateTime.fromMillisecondsSinceEpoch(timeStamp.seconds * 1000);
    return DateFormat('dd-MMM-yyyy').format(dateFromTimeStamp);
  }




}
