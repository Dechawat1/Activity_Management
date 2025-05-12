import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:intl/intl.dart';
import 'package:mobileapp/Login.dart';
import 'package:mobileapp/Screen/Activity.dart';
import 'package:mobileapp/Screen/HomeWork.dart';
import 'package:mobileapp/Screen/Schedule.dart';
import 'package:mobileapp/page_Main.dart';

import 'Homeworktest.dart';
import 'Screen/Profile.dart';
import 'Screen/assignment_screen.dart';
import 'Widget/theme.dart';
import 'models/user.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final currentUser = FirebaseAuth.instance.currentUser;
  DateTime _selectedDate = DateTime.now();
  int _selectedIndex = 0;
  String? name, email, Url;
  int? itemHomework;
  int? itemSchedule;
  int? itemActive;
  int? itemAssignment;

  Future<void> readitemHomework() async {
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
              .collection("Notes")
              .get()
              .then((subcol) {
            setState(() {
              itemHomework = subcol.docs.length;
            });
          });
        }
      });
    });
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
            setState(() {
              itemAssignment = subcol.docs.length;
            });
          });
        }
      });
    });
  }

  Future<void> readitemSchedule() async {
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
              .collection("schedules")
              .get()
              .then((subcol) {
            setState(() {
              itemSchedule = subcol.docs.length;
            });
          });
        }
        ;
      });
    });
  }

  Future<void> readiTemActive() async {
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
              .collection("Activity")
              .get()
              .then((subcol) {
            setState(() {
              itemActive = subcol.docs.length;
            });
          });
        }
        ;
      });
    });
  }

  Future<void> findName() async {
    await Firebase.initializeApp().then((value) async {
      await FirebaseAuth.instance.authStateChanges().listen((event) async {
        String? uid = event?.uid;
        await FirebaseFirestore.instance
            .collection('users')
            .doc(uid)
            .snapshots()
            .listen((event) {
          print('snapshot = ${event.id}');
          for (var snapshots in {event.id}) {
            UserModel model = UserModel.fromMap(event.data()!);
            print('Name ${model.name}');
            setState(() {
              name = model.name;
              print(name);
              email = model.email;
              Url = model.imageUrl;
            });
          }
        });
      });
    });
  }

  @override
  void initState() {
    readitemHomework();
    readitemSchedule();
    readiTemActive();
    readitemAssignment();
    findName();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      // drawer: _mydrawer(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            _addTaskBar(),
            SizedBox(
              height: 30,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 25,
                ),
                Container(
                    height: 60,
                    width: 60,
                    child: Image.asset('assets/schedule 1.png')),
                SizedBox(
                  width: 35,
                ),
                Container(
                    height: 60,
                    width: 57,
                    child: Image.asset('assets/notes.png')),
                SizedBox(
                  width: 35,
                ),
                Container(
                    height: 60,
                    width: 57,
                    child: Image.asset('assets/activity.png')),
                SizedBox(
                  width: 35,
                ),
                Container(
                    height: 60,
                    width: 57,
                    child: Image.asset('assets/homework.png')),
              ],
            ),
            Row(
              children: [
                SizedBox(
                  width: 25,
                ),
                Text(
                  'Schedule',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  width: 55,
                ),
                Text(
                  'Notes',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  width: 58,
                ),
                Text(
                  'Activity',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  width: 42,
                ),
                Text(
                  'Assignment',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.only(left: 30),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.6,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
                color: Color.fromRGBO(79, 109, 166, 1),
              ),
              child: Stack(
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.only(top: 30, left: 5),
                            child: Text(
                              'Dashboard',
                              style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          // SizedBox(width: 15,),
                          buildClassroom(),
                          SizedBox(width: 10),
                          buildNotes(),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          // SizedBox(width: 15,),
                          buildHomework(),
                          SizedBox(width: 10),

                          buildActivity(),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildClassroom() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ScheduleScreen()));
      },
      child: Container(
        width: 160,
        // constraints: BoxConstraints(
        //   maxHeight: 200,
        //   maxWidth: 200,
        // ),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                height: 35,
                width: 40,
                child: Image.asset('assets/schedule.png')),
            // Icon(Icons.menu_book, color: blueClr2, size: 35),
            SizedBox(
              height: 30,
            ),
            Text(
              'Class Schedule',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  width: 100,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(255, 124, 51, 1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                          child: Text(
                        itemSchedule.toString() + 'item',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      )),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildNotes() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomeWorkScreem()));
      },
      child: Container(
        width: 160,
        // constraints: BoxConstraints(
        //   maxHeight: 200,
        //   maxWidth: 200,
        // ),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                height: 35, width: 40, child: Image.asset('assets/notes.png')),
            // Icon(Icons.access_time_filled, color: greenClr, size: 35),
            SizedBox(
              height: 30,
            ),
            Text(
              'Notes',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  width: 100,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(232, 78, 78, 1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                          child: Text(
                              itemActive.toString() == null
                                  ? '0'
                                  : itemActive.toString() + 'item',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold))),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget buildActivity() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ActivityScreen()));
      },
      child: Container(
        width: 160,
        // constraints: BoxConstraints(
        //   maxHeight: 200,
        //   maxWidth: 200,
        // ),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                height: 35,
                width: 40,
                child: Image.asset('assets/activity.png')),
            // Icon(Icons.home_work_outlined, color: bluishClr3, size: 35),
            SizedBox(
              height: 30,
            ),
            Text(
              'Activity',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  width: 100,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(44, 178, 98, 1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                          child: Text(itemHomework.toString() + 'item',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold))),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget buildHomework() {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => AssignmentScreen()));
      },
      child: Container(
        width: 160,
        // constraints: BoxConstraints(
        //   maxHeight: 200,
        //   maxWidth: 200,
        // ),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                height: 35,
                width: 40,
                child: Image.asset('assets/homework.png')),
            // Icon(Icons.menu_book, color: blueClr2, size: 35),
            SizedBox(
              height: 30,
            ),
            Text(
              'Assignment',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            SingleChildScrollView(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    width: 100,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(133, 110, 184, 1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                            child: Text(
                          itemAssignment.toString() + 'item',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      actions: [
        IconButton(
          splashColor: Colors.red,
          disabledColor: Colors.red,
          color: Colors.red,
          hoverColor: Colors.red,
            highlightColor: Colors.red,
            onPressed: ()async {
              await Firebase.initializeApp().then((value) async {
                AwesomeDialog(
                  context: context,
                  dialogType: DialogType.warning,
                  animType: AnimType.topSlide,
                  showCloseIcon: true,
                  title: "Warning",
                  desc: "คุณต้องการออกจากระบบ ? ",
                  descTextStyle:
                  TextStyle(fontSize: 15, fontWeight: FontWeight.w300),
                  btnOkOnPress: () async {
                    await FirebaseAuth.instance.signOut().then((value) => {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginPage())),
                    });
                  },
                  btnCancelOnPress: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MainScreen()));
                  },
                ).show();
              });


            },
            icon: Icon(Icons.logout,color: Colors.white,))
      ],
      backgroundColor: Color.fromRGBO(79, 109, 166, 1),
      elevation: 10,
      shadowColor: Colors.blue.shade300,
      automaticallyImplyLeading: false,
      title: Center(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: SizedBox(
                height: 50,
                width: 50,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Profile()));
                  },
                  child: ClipOval(
                    // borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      Url == null
                          ? 'https://firebasestorage.googleapis.com/v0/b/projectmobileapp-a6362.appspot.com/o/photo%20Mobile%20app%2Fuser.png?alt=media&token=b3c304e4-893e-4038-9d34-e48e60e5b13d'
                          : Url!,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              name == null ? 'User' : name!,
              style: TextStyle(
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
      // actions: [
      //   Icon(Icons.more_horiz,color: Colors.black,size: 40,)
      // ],
    );
  }

  Drawer _mydrawer() {
    return Drawer(
      child: ListView(
        // padding: const EdgeInsets.all(5.0),
        shrinkWrap: true,
        children: [
          UserAccountsDrawerHeader(
              currentAccountPicture: ClipOval(
                child: Image.network(
                  Url == null
                      ? 'https://icons.veryicon.com/png/o/internet--web/prejudice/user-128.png'
                      : Url!,
                  fit: BoxFit.cover,
                ),
              ),
              decoration: const BoxDecoration(
                color: Color.fromRGBO(218, 87, 87, 1),

                // image: DecorationImage(
                //     image: NetworkImage(
                //         'https://digwallpapers.com/wallpapers/full/5/1/a/37733-1920x1200-starry-night-background-image-desktop-hd.jpg')),
              ),
              accountName: Text(
                name == null ? 'Name' : name!,
                // name == null ? 'Name' : name!,
                style: const TextStyle(fontSize: 19.0, color: Colors.white),
              ),
              accountEmail: Text(
                email == null ? 'Email' : email!,
                // email == null ? 'Email' : email!,
                style: TextStyle(fontSize: 17.0, color: Colors.white),
              )),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text(
              'หน้าหลัก',
              style: TextStyle(fontSize: 17),
            ),
            subtitle: const Text('home'),
            onTap: () => onItemPressed(context, index: 0),
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text(
              'โปรไฟล์',
              style: TextStyle(fontSize: 17),
            ),
            subtitle: const Text('profile'),
            onTap: () => onItemPressed(context, index: 1),
          ),
          const SizedBox(
            height: 355,
          ),
          const Divider(),
          ListTile(
            contentPadding: EdgeInsets.all(2),
            dense: true,
            enabled: true,
            onTap: () async {
              await Firebase.initializeApp().then((value) async {
                AwesomeDialog(
                  context: context,
                  dialogType: DialogType.warning,
                  animType: AnimType.topSlide,
                  showCloseIcon: true,
                  title: "Warning",
                  desc: "คุณต้องการออกจากระบบ ? ",
                  descTextStyle:
                      TextStyle(fontSize: 15, fontWeight: FontWeight.w300),
                  btnOkOnPress: () async {
                    await FirebaseAuth.instance.signOut().then((value) => {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginPage())),
                        });
                  },
                  btnCancelOnPress: () {
                    Navigator.pop(context);
                  },
                ).show();
              });
            },
            tileColor: Colors.red,
            leading: const Icon(Icons.logout_outlined),
            title: const Text(
              'ออกจากระบบ',
              style: TextStyle(fontSize: 17.0),
            ),
            subtitle: const Text('Logout'),
          ),
        ],
      ),
    );
  }

  void onItemPressed(BuildContext context, {required int index}) {
    Navigator.pop(context);
    switch (index) {
      case 0:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const HomeScreen()));
        break;
      case 1:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const Profile()));
        break;
      case 2:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const LoginPage()));
        break;
      default:
        Navigator.pop(context);
        break;
    }
  }

  _addTaskBar() {
    return Container(
      margin: const EdgeInsets.only(left: 5, right: 5, top: 5),
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    DateFormat.yMMMMd().format(DateTime.now()),
                    style: subHeadingStyle,
                  ),
                  Text(
                    "Today",
                    style: headingStyle,
                  ),
                ],
              ),
            ),
            Row(
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Profile()));
                  },
                  child: Container(
                    height: 40,
                    width: 129,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: [BoxShadow(
                        color: Color.fromRGBO(79, 109, 166, 1),
                        blurRadius: 2,
                      )],
                      color: Colors.white
                    ),
                    child:   Center(
                      child: Text(
                        'My profile',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  )
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  _buildBottomNavigationBar() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 5,
                blurRadius: 10),
          ]),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        child: BottomNavigationBar(
            items: [
              BottomNavigationBarItem(
                  backgroundColor: Color(0xFF80DEEA),
                  label: 'HOME',
                  icon: Icon(Icons.home_rounded, size: 30)),
              BottomNavigationBarItem(
                  backgroundColor: Color(0xFF80DEEA),
                  label: 'ตารางเรียน',
                  icon: Icon(Icons.menu_book, size: 30)),
              BottomNavigationBarItem(
                  backgroundColor: Color(0xFF80DEEA),
                  label: 'กิจกรรม',
                  icon: Icon(Icons.access_time_filled, size: 30)),
              BottomNavigationBarItem(
                  backgroundColor: Color(0xFF80DEEA),
                  label: 'การบ้าน',
                  icon: Icon(
                    Icons.home_work_outlined,
                    size: 30,
                  )),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.white,
            onTap: (int index) {
              setState(
                () {
                  _selectedIndex = index;
                  if (_selectedIndex == 0) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return HomeScreen();
                    }));
                  } else if (_selectedIndex == 1) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return const ScheduleScreen();
                    }));
                  } else if (_selectedIndex == 2) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return const ActivityScreen();
                    }));
                  } else if (_selectedIndex == 3) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return const HomeWorkScreem();
                    }));
                  }
                },
              );
            }),
      ),
    );
  }
}
