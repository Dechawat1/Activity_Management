

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobileapp/Screen_colors/note_edit.dart';
import 'package:mobileapp/Screen_colors/note_reader.dart';
import 'package:mobileapp/style/app_style.dart';

import '../Widget/theme.dart';
import '../Widget/utility.dart';
import '../models/Note.dart';

class HomeWorkScreem extends StatefulWidget {
  const HomeWorkScreem({Key? key}) : super(key: key);

  @override
  State<HomeWorkScreem> createState() => _HomeWorkScreemState();
}

class _HomeWorkScreemState extends State<HomeWorkScreem> {
  List<Widget> widgets = [];
  var firebaseUser = FirebaseAuth.instance.currentUser;
  CollectionReference? taskRef;

  int? item;







  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    String uid = FirebaseAuth.instance.currentUser!.uid;
    taskRef = FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('Notes');
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(79, 109, 166, 1),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0.0,
        backgroundColor: Color.fromRGBO(79, 109, 166, 1),
        centerTitle: true,
        title: Text(
          'Your recent Notes',
          style: TextStyle(color: Colors.white,),
        ),

      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
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
                            child: Image.asset('assets/notes.png'),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text('List Notes',style: TextStyle(fontSize: 17,fontWeight: FontWeight.w500),),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20,),
          // Center(child: Text("Your recent Notes",style: GoogleFonts.roboto(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 22),)),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: taskRef!.snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: Text('No Tasks Yet'),
                    );
                  } else {
                    return GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1,
                          crossAxisSpacing: 1, mainAxisSpacing: 1
                      ),
                      itemCount: snapshot.data!.docs.length ,
                      itemBuilder: (context, index) {
                        return RepaintBoundary(
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            // width: MediaQuery.of(context).size.width,
                            // height: MediaQuery.of(context).size.height,
                            constraints: BoxConstraints(
                              maxHeight: MediaQuery.of(context).size.height,
                            ),
                            margin: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              color: AppStyle.cardsColor[snapshot.data!.docs[index]['color_id']],
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Stack(
                              children: [
                                ListView(
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    children: [
                                      Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Text(
                                              "หัวข้อ: " + snapshot.data!.docs[index]['note_title'],
                                              style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Text( "วันที่บันทึก: " +
                                              Utility.getHumanReadableDate(
                                                  snapshot.data!.docs[index]['creation_data'] ?? '0'),
                                              style: TextStyle(fontWeight: FontWeight.w500,fontSize: 18),
                                            ),
                                            const SizedBox(height: 20),
                                            Text("เนื้อหา :  " + snapshot.data!.docs[index]['note_content'],
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w400, fontSize: 18.0),maxLines: 5,),
                                            SizedBox(height: 100,),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.end,
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              children: [

                                                Row(
                                                   crossAxisAlignment: CrossAxisAlignment.end,
                                                   mainAxisAlignment: MainAxisAlignment.end,
                                                  children: [
                                                    // SizedBox(height: 10,),
                                                    IconButton(
                                                      onPressed: ()  async {
                                                        AwesomeDialog(
                                                          context: context,
                                                          dialogType: DialogType.warning,
                                                          animType: AnimType.scale,
                                                          showCloseIcon: true,
                                                          title: "Warning",
                                                          desc: "คุณต้องการลบNotes ? ",
                                                          descTextStyle:
                                                          const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                                          btnOkOnPress: () async {
                                                            if (taskRef != null) {
                                                              await taskRef!
                                                                  .doc(
                                                                  '${snapshot.data!.docs[index]['NotesId']}')
                                                                  .delete();
                                                            }
                                                          },
                                                          btnCancelOnPress: () {

                                                             Navigator.push(context, MaterialPageRoute(builder: (context)=> HomeWorkScreem()));
                                                          },
                                                        ).show();

                                                      },
                                                      icon: Icon(Icons.delete,size: 30,),
                                                      color: Colors.red,
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ]),
                                    ]),
                              ],
                            ),
                          ),
                        );
                      },





                    );







                  }
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
        ],
      ),

      // GridView.extent(
      //   maxCrossAxisExtent: 200,
      //
      //   children: widgets,
      // ),
      floatingActionButton: FloatingActionButton.extended(
        elevation: 0.0,
        backgroundColor: Colors.blue,
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => NoteEditorScreen()));
        },
        label: Text("Add Note"),
        icon: Icon(Icons.add),
      ),
    );
  }
}
