import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mobileapp/models/profile.dart';
import 'package:provider/provider.dart';

import '../Login.dart';
import '../models/user.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  var firebaseUser = FirebaseAuth.instance.currentUser;
  String uid = FirebaseAuth.instance.currentUser!.uid;
  String? name,email,Url,phone;

  Future<void> findName() async {
    await Firebase.initializeApp().then((value) async {
      await FirebaseAuth.instance.authStateChanges().listen((event) async {
        String? uid = event?.uid;
        await FirebaseFirestore.instance
            .collection('users')
            .doc(uid)
            .snapshots()
            .listen((event) {
          for (var snapshots in {event.id}) {
            UserModel model = UserModel.fromMap(event.data()!);
            setState(() {
              name = model.name;
              email = model.email;
              Url = model.imageUrl;
              phone = model.phone;
            });
          }
        });
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    findName();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(79, 109, 166, 1),
        // actions: [
        //   IconButton(
        //     color: Colors.red,
        //       onPressed: ()
        //          async {
        //           await Firebase.initializeApp().then((value) async {
        //             AwesomeDialog(
        //               context: context,
        //               dialogType: DialogType.warning,
        //               animType: AnimType.topSlide,
        //               showCloseIcon: true,
        //               title: "Warning",
        //               desc: "คุณต้องการออกจากระบบ ? ",
        //               descTextStyle:
        //               TextStyle(fontSize: 15, fontWeight: FontWeight.w300),
        //               btnOkOnPress: () async {
        //                 await FirebaseAuth.instance.signOut().then((value) => {
        //                   Navigator.push(
        //                       context,
        //                       MaterialPageRoute(
        //                           builder: (context) => const LoginPage())),
        //                 });
        //               },
        //               btnCancelOnPress: () {
        //                 Navigator.pop(context);
        //               },
        //             ).show();
        //           });
        //
        //
        //       },
        //       icon: Icon(Icons.logout,color: Colors.red,))
        // ],
      ),
        body: ChangeNotifierProvider(
          create: (_) => ProfileController(),
          child: Consumer<ProfileController>(
            builder: (context, provider, child) {
              return SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(height: 20,),
                      Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10 ),
                              child: Center(
                                child: Container(
                                  height: 130,
                                  width: 130,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Colors.black,

                                      )
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: Url == null ?Icon(Icons.person, size: 35,)
                                        : Image.network( Url == null ? 'https://png.pngtree.com/png-clipart/20220303/original/pngtree-action-cartoon-cute-godzilla-character-avatar-png-image_7400326.png' : Url!,
                                      fit: BoxFit.cover,

                                    ),
                                  ),
                                ),
                              ),
                            ),
                            // InkWell(
                            //   onTap: (){
                            //     provider.pickImage(context);
                            //
                            //   },
                            //   child: CircleAvatar(
                            //     radius: 16,
                            //     backgroundColor: Colors.black,
                            //     child: Icon(Icons.add,color: Colors.white,size: 15,),
                            //   ),
                            // )
                          ]
                      ),
                      SizedBox(height: 40,),
                      ReusbaleRow(title: 'E-mail', value: email == null ? 'xxxx@xxxx': email!, iconData: Icons.email_outlined),
                      ReusbaleRow(title: 'Phone', value: phone == null ? 'xxx-xxx-xxxx' : phone!, iconData: Icons.phone_outlined),
                      ReusbaleRow(title: 'full-name', value: name == null ? 'xxxxxxx' : name!, iconData: Icons.person_outline),
                      SizedBox(height: 40,),
                      GestureDetector(
                        onTap: () async {
                          await FirebaseAuth.instance.signOut().then((value) => {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginPage())),
                          });
                        },
                        child: Container(
                          height: 50,
                          width: 150,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.all(Radius.circular(16)),

                          ),
                          child: Center(child: Text('LogOut',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),)),
                        ),
                      ),

                    ],
                  ),
                ),
              );
            },
          ),
        )
    );
  }
}

class ReusbaleRow extends StatelessWidget {
  final String title, value ;
  final IconData iconData ;
  const ReusbaleRow({Key? key, required this.title , required this.value ,required this.iconData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(title, style:  Theme.of(context).textTheme.subtitle2,),
          leading: Icon(iconData , color:  Colors.grey,),
          trailing: Text(value, style:  Theme.of(context).textTheme.subtitle2,),
        ),
        Divider(color: Colors.grey.withOpacity(0.4))
      ],
    );
  }
}

