import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:mobileapp/HomeScreen.dart';
import 'package:mobileapp/Login.dart';
import 'package:mobileapp/Widget/profile.dart';
import 'package:mobileapp/page_Main.dart';
import 'package:mobileapp/sevice/auth.dart';

import 'Screen_colors/Register_colors.dart';


class RegisterPage extends StatefulWidget{
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  AuthService authService = AuthService();
  Profile profile = Profile();
  final bool _isHidden = true;
  final formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SizedBox(
        height: height,
        child: Stack(
          children: [
            Positioned(
                height: height * 0.90,
                child: const RegisterContainer()),
            SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          SizedBox(height: height * .4),
                          _nameWidget(),
                          const SizedBox(height: 20),
                          _phoneWidget(),
                          const SizedBox(height: 20),
                          _EmailWidget(),
                          const SizedBox(height: 20),
                          _passwordWidget(),
                        ],
                      ),
                    ),
                    const SizedBox(height: 40),
                    _submitButton(),
                    const SizedBox(height: 0.9),
                    _createLoginLabel(context),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _nameWidget() {
    return Stack(
      children: [
        TextFormField(
          controller: authService.name,
          keyboardType: TextInputType.name,
          textInputAction: TextInputAction.next,
          validator: RequiredValidator(
              errorText: "กรุณากรอกชื่อผู้ใช้งานด้วยครับ"),
          decoration: const InputDecoration(
            prefixIcon:
            Icon(Icons.person,color: Colors.lightBlue,),
            labelText: 'Name',
            labelStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),
          ),
        ),
      ],
    );
  }

  Widget _EmailWidget() {
    return TextFormField(
      controller: authService.email,
      onChanged: (value) =>
      profile.email = value.trim(),
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      validator: MultiValidator([
        RequiredValidator(
            errorText: "กรุณาป้อนอีเมลด้วยครับ"),
        EmailValidator(
            errorText: "รูปแบบอีเมลไม่ถูกต้อง")
      ]),
      decoration:  InputDecoration(
        prefixIcon:
        Icon(Icons.email,color: Colors.lightBlue,),
        hintText: 'Enter your Account ',
        labelText: 'Email',
        labelStyle: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
      ),
    );
  }

  Widget _passwordWidget() {
    return TextFormField(
      controller: authService.password,
      onChanged: (value) =>
      profile.password = value.trim(),
      keyboardType: TextInputType.visiblePassword,
      textInputAction: TextInputAction.next,
      obscureText: _isHidden,
      validator: RequiredValidator(
          errorText: "กรุณาป้อนรหัสผ่านด้วยครับ"),
      decoration:  InputDecoration(
        contentPadding: const EdgeInsets.all(0.3),
        prefixIcon:
        const Icon(Icons.lock_outline_rounded,color: Colors.lightBlue),
        hintText: 'Enter your Password',
        labelText: 'Password',
        labelStyle: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black)),
        ),
      );

  }
  Widget _phoneWidget() {
    return TextFormField(
      controller: authService.phone,
      onChanged: (value) =>
      profile.phone = value.trim(),
      keyboardType: TextInputType.visiblePassword,
      textInputAction: TextInputAction.next,
      validator: RequiredValidator(
          errorText: "กรุณาป้อนเบอร์โทรด้วยครับ"),
      decoration:  InputDecoration(
        contentPadding: const EdgeInsets.all(0.3),
        prefixIcon:
        const Icon(Icons.phone_outlined,color: Colors.lightBlue),
        hintText: 'Enter your Phone',
        labelText: 'Phone',
        labelStyle: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold),
        enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black)),
      ),
    );

  }

  Widget _submitButton() {
    return Align(
      alignment: Alignment.centerRight,
      child: InkWell(
        onTap: () {
          {
            if (formKey.currentState!.validate()) {
              formKey.currentState?.save();
              try {
                if(authService.email != "" && authService.password != "" ){
                  authService.RegisterUser(context);
                  formKey.currentState?.reset();
                  AwesomeDialog(
                                              context: context,
                                              dialogType: DialogType.success,
                                              animType: AnimType.topSlide,
                                              showCloseIcon: true,
                                              title: "Success",
                                              desc: "สมัครสมาชิกสำเร็จ ! ",
                                              descTextStyle: TextStyle(fontSize: 15,fontWeight: FontWeight.w300),
                                              btnOkOnPress: (){
                                                 Navigator.push(context,
                                                    MaterialPageRoute(
                                                        builder: (context) {
                                                          return  const MainScreen();
                                                        }));
                                        
                                              },
                                            ).show();
                }
          

              }catch (e) {
                AwesomeDialog(
                                            context: context,
                                            dialogType: DialogType.error,
                                            animType: AnimType.topSlide,
                                            showCloseIcon: true,
                                            title: "โปรดกรอกรหัสผ่านให้ถูกต้อง",
                                            btnOkOnPress: (){},
                                          ).show();
              }
            }

          };
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
              'Register',
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

  Widget _createLoginLabel(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      padding: const EdgeInsets.all(15),
      alignment: Alignment.bottomLeft,
      child: InkWell(
        onTap: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) =>  LoginPage())),
        child: const Text(
          'Login',
          style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
              decorationThickness: 2),
        ),
      ),
    );
  }
}