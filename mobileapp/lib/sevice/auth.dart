import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobileapp/models/user.dart';

class AuthService {
  final auth = FirebaseAuth.instance;
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController phone = TextEditingController();

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
                print(name.text),
                Navigator.pop(context),
              });
    } catch (e) {
      print(e);
    }
  }

  void RegisterUser(context) async {
    try {
      await auth
          .createUserWithEmailAndPassword(
              email: email.text, password: password.text)
          .then((value) async {
        User? user = FirebaseAuth.instance.currentUser;
        print("User Is Registered");

        UserModel model = UserModel(
            email: email.text,
            name: name.text,
            password: password.text,
            imageUrl: 'https://png.pngtree.com/png-clipart/20220303/original/pngtree-action-cartoon-cute-godzilla-character-avatar-png-image_7400326.png',
            phone: phone.text);
        Map<String, dynamic> data = model.toMap();
        await FirebaseFirestore.instance
            .collection("users")
            .doc(user?.uid)
            .set(data)
            .then((value) => print('สำเร็จ'));
        return print("User Is Registered");
        /* Navigator.push(
            context, MaterialPageRoute(builder: (context) => Login())); */
      });
    } catch (e) {
      print(e);
    }
  }
}
