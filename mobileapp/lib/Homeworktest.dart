import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobileapp/Login.dart';
import 'package:mobileapp/Widget/note_card.dart';
import 'package:mobileapp/style/app_style.dart';

import 'Widget/addtaks.dart';
import 'Widget/utility.dart';


class TaskListScreen extends StatefulWidget {
  const TaskListScreen({Key? key}) : super(key: key);

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
   CollectionReference? taskRef;


  @override
  void initState() {
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
      appBar: AppBar(
        title: const Text('Notes List'),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(Icons.person)),
          IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (ctx) {
                      return AlertDialog(
                        title: const Text('Confirmation !!!'),
                        content: const Text('Are you sure to Log Out ? '),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(ctx).pop();
                            },
                            child: const Text('No'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(ctx).pop();

                              FirebaseAuth.instance.signOut();

                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(builder: (context) {
                                    return const LoginPage();
                                  }));
                            },
                            child: const Text('Yes'),
                          ),
                        ],
                      );
                    });
              },
              icon: const Icon(Icons.logout)),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return const AddTaskScreen();
          }));
        },
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                          crossAxisCount: 2,
                            crossAxisSpacing: 10, mainAxisSpacing: 10
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
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    "title: " + snapshot.data!.docs[index]['note_title'],
                                                    style: AppStyle.mainTitle,
                                                  ),
                                                  SizedBox(
                                                    height: 12,
                                                  ),
                                                  Text(
                                                    Utility.getHumanReadableDate(
                                                        snapshot.data!.docs[index]['creation_data'] ?? '0'),
                                                    style: AppStyle.dateTitle,
                                                  ),
                                                  const SizedBox(height: 12),
                                                  Text("Note content ",
                                                      style: TextStyle(
                                                          fontWeight: FontWeight.w600, fontSize: 15.0)),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    snapshot.data!.docs[index]['note_content'],
                                                    style: AppStyle.mainContent,
                                                    maxLines: 6,
                                                  ),
                                                  Row(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    mainAxisAlignment: MainAxisAlignment.end,
                                                    children: [
                                                      // SizedBox(height: 10,),
                                                      IconButton(
                                                        onPressed: ()  {

                                                        },
                                                        icon: Icon(Icons.delete),
                                                        color: Colors.red,
                                                      ),
                                                    ],
                                                  )
                                                ]),
                                          ]),
                                    ],
                                  ),
                                ),
                              );
                            },





                          );






                      return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: ( context,  index) {
                          return Container(
                            padding: const EdgeInsets.all(10),
                            margin: const EdgeInsets.only(bottom: 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(snapshot.data!.docs[index]['taskName'] ?? 'Name'),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(Utility.getHumanReadableDate(
                                            snapshot.data!.docs[index]['dt'] ?? '0'))
                                      ],
                                    )),
                                Column(
                                  children: [
                                    IconButton(
                                        onPressed: () {},
                                        // {
                                        //
                                        //   Navigator.of(context).push(MaterialPageRoute(builder: (context){
                                        //     return UpdateTaskScreen(documentSnapshot: snapshot.data!.docs[index]);
                                        //   }));
                                        // },
                                        icon: const Icon(
                                          Icons.edit,
                                          size: 20,
                                        )),
                                    IconButton(
                                        onPressed: () {
                                          showDialog(
                                              barrierDismissible: false,
                                              context: context,
                                              builder: (ctx) {
                                                return AlertDialog(
                                                  title:
                                                  const Text('Confirmation !!!'),
                                                  content: const Text(
                                                      'Are you sure to delete ? '),
                                                  actions: [
                                                    TextButton(
                                                        onPressed: () {
                                                          Navigator.of(ctx).pop();
                                                        },
                                                        child: const Text('No')),
                                                    TextButton(
                                                        onPressed: () async {
                                                          Navigator.of(ctx).pop();

                                                          if (taskRef != null) {
                                                            await taskRef!
                                                                .doc(
                                                                '${snapshot.data!.docs[index]['taskId']}')
                                                                .delete();
                                                          }
                                                        },
                                                        child: const Text('Yes')),
                                                  ],
                                                );
                                              });
                                        },
                                        icon: const Icon(
                                          Icons.delete,
                                          size: 20,
                                        )),
                                  ],
                                )
                              ],
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
      ),
    );
  }
}