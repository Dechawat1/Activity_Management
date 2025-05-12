import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';


import 'Input_filed.dart';
import 'button.dart';

class AddSchedule extends StatefulWidget {
  const AddSchedule({Key? key}) : super(key: key);

  @override
  State<AddSchedule> createState() => _AddScheduleState();
}

class _AddScheduleState extends State<AddSchedule> {
  final TextEditingController _subjectNameController = TextEditingController();
  final TextEditingController _dayController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _roomController = TextEditingController();
  String? uid = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(90, 133, 215, 1),
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20,),
              Text(
                "Add Schedul ",
                style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),
              ),
              MyInputField(
                title: "Subject",
                hint: "Enter your Subject",
                controller: _subjectNameController,
              ),
              SizedBox(height: 20,),
              MyInputField(
                title: "Day",
                hint: "Enter your Monday",
                controller: _dayController,
              ),
              SizedBox(height: 20,),
              MyInputField(
                title: "Time",
                hint: "Enter your 12.00-16.00",
                controller: _timeController,
              ),
              SizedBox(height: 20,),
              MyInputField(
                title: "Room",
                hint: "Enter your 1404",
                controller: _roomController,
              ),
              SizedBox(height: 100,),
              Container(
                margin: const EdgeInsets.only(right: 5),
                child: Padding(
                  padding: const EdgeInsets.only(right: 1.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(width: 5,),
                      MyButton(label: "Create Schedule", onTap: () => _validateDate())
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  _validateDate() {
    if (_subjectNameController.text.isNotEmpty && _dayController.text.isNotEmpty && _timeController.text.isNotEmpty && _roomController.text.isNotEmpty) {
      setState(() {
        _addHomework();
      });
      Get.back();
    } else if (_subjectNameController.text.isEmpty || _dayController.text.isEmpty || _timeController.text.isEmpty || _roomController.text.isEmpty) {
      Get.snackbar("Required", "All fields are required !",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.white,
          icon: const Icon(
            Icons.warning_amber_rounded,
            color: Colors.red,
          ));
    }
  }
  void _addHomework() async {
    final subject = _subjectNameController.text;
    final day = _dayController.text;
    final time = _timeController.text;
    final room = _roomController.text;

    if (subject.isEmpty && day.isEmpty && time.isEmpty && room.isEmpty) {
      print('cannot be empty');
      return;
    }
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    var scheduleRef = firestore.collection('users').doc(uid).collection('schedules').doc();
    await scheduleRef.set({
      "subject": subject,
      "day": day,
      "room": room,
      "time": time,
      'ScheduleId': scheduleRef.id,
    });
    if (mounted) {
      Navigator.pop<bool>(context, true);
    }
  }
}
