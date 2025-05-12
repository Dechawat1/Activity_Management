import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:mobileapp/page_Main.dart';
import 'package:mobileapp/sevice/auth.dart';

import 'Register.dart';
import 'HomeScreen.dart';
import 'Screen_colors/Login_colors.dart';
import 'Widget/profile.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  AuthService authService = AuthService();
  Profile profile = Profile();
  bool _isHidden = true;
  final Future<FirebaseApp> firebase = Firebase.initializeApp();
  final formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return FutureBuilder(
        future: firebase,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Scaffold(
              appBar: AppBar(),
              body: Center(
                child: Text("${snapshot.error}"),
              ),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return Scaffold(
              body: SizedBox(
                height: height,
                child: Stack(
                  children: [
                    Positioned(height: height * 0.43, child: LoginContainer()),
                    SingleChildScrollView(
                      child: Form(
                        key: formKey,
                        child: Column(
                          children: <Widget>[
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Column(
                                children: [
                                  SizedBox(height: height * .45),
                                  _EmailWidget(),
                                  const SizedBox(height: 20),
                                  _passwordWidget(),
                                ],
                              ),
                            ),
                            const SizedBox(height: 30),
                            _submitButton(),
                            SizedBox(height: height * .10),
                            _createAccountLabel(context),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(
                color: Colors.blueAccent,
                backgroundColor: Colors.white,
              ),
            ),
          );
        });
  }

  Widget _EmailWidget() {
    return TextFormField(
      controller: authService.email,
      onChanged: (value) => profile.email = value.trim(),
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      validator: MultiValidator([
        RequiredValidator(errorText: "กรุณาป้อนอีเมลด้วยครับ"),
        EmailValidator(errorText: "รูปแบบอีเมลไม่ถูกต้อง")
      ]),
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.person, color: Colors.lightBlue),
        hintText: 'Enter your Account ',
        labelText: 'Email',
        labelStyle: TextStyle(
            color: Color.fromRGBO(173, 183, 192, 1),
            fontSize: 15,
            fontWeight: FontWeight.bold),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color.fromRGBO(173, 183, 192, 1)),
        ),
      ),
    );
  }

  Widget _passwordWidget() {
    return TextFormField(
      controller: authService.password,
      onChanged: (value) => profile.password = value.trim(),
      keyboardType: TextInputType.visiblePassword,
      textInputAction: TextInputAction.next,
      obscureText: _isHidden,
      validator: RequiredValidator(errorText: "กรุณาป้อนรหัสผ่านด้วยครับ"),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(0.3),
        prefixIcon:
            const Icon(Icons.lock_outline_rounded, color: Colors.lightBlue),
        hintText: 'Enter your Password',
        suffixIcon: togglePassword(),
        labelText: 'Password',
        labelStyle: const TextStyle(
            color: Color.fromRGBO(173, 183, 192, 1),
            fontSize: 15,
            fontWeight: FontWeight.bold),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Color.fromRGBO(173, 183, 192, 1)),
        ),
      ),
    );
  }

  Widget _submitButton() {
    return Align(
      alignment: Alignment.centerRight,
      child: InkWell(
        onTap: () async {
          if (formKey.currentState!.validate()) {
            formKey.currentState?.save();
            try {
              await FirebaseAuth.instance
                  .signInWithEmailAndPassword(
                      email: profile.email!, password: profile.password!)
                  .then((value) {
                formKey.currentState?.reset();
                AwesomeDialog(
                                              context: context,
                                              dialogType: DialogType.success,
                                              animType: AnimType.topSlide,
                                              showCloseIcon: true,
                                              title: "Success",
                                              desc: "ยินดีต้อนรับเข้าสู่ระบบ ! ",
                                              descTextStyle: TextStyle(fontSize: 15,fontWeight: FontWeight.w300),
                                              btnOkOnPress: (){
                                                Navigator.push(context,
                                                    MaterialPageRoute(
                                                        builder: (context) {
                                                          return  MainScreen();
                                                        }));
                                              },
                                            ).show();
              });
            } on FirebaseAuthException catch (e) {
              AwesomeDialog(
                                            context: context,
                                            dialogType: DialogType.error,
                                            animType: AnimType.topSlide,
                                            showCloseIcon: true,
                                            title: "Error",
                                            desc: "โปรดตรวจสอบผู้ใช้หรือรหัสผ่านอีกครั้ง !",
                                            btnOkOnPress: (){},
                                          ).show();
            }
          }
        },
        child: Stack(children: [
          Positioned(
            right: 20,
            child: SizedBox.fromSize(
              size: const Size.square(80.0), // button width and height
              child: const ClipOval(
                child: Material(
                  color: Color.fromRGBO(252, 228, 138, 1), // button color
                ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(right: 50, bottom: 20),
            child: Text(
              'Login',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  height: 1.6),
            ),
          ),
        ]),
      ),
    );
  }

  Widget _createAccountLabel(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      padding: const EdgeInsets.all(15),
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          InkWell(
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => const RegisterPage())),
            child: const Text(
              'Register',
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                  decorationThickness: 2),
            ),
          ),
          const InkWell(
            // onTap: (){},
            child: Text(
              'Forgot Password',
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                  decorationThickness: 2),
            ),
          ),
        ],
      ),
    );
  }

  Widget togglePassword() {
    return IconButton(
      onPressed: () {
        setState(() {
          _isHidden = !_isHidden;
        });
      },
      icon: _isHidden
          ? const Icon(Icons.visibility)
          : const Icon(Icons.visibility_off),
      color: Colors.grey,
    );
  }
}
