import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:intl/intl.dart';

import 'Input_filed.dart';
import 'button.dart';

class AddAssignment extends StatefulWidget {
  const AddAssignment({Key? key}) : super(key: key);

  @override
  State<AddAssignment> createState() => _AddAssignmentState();
}

class _AddAssignmentState extends State<AddAssignment> {
  final TextEditingController _subjectNameController = TextEditingController();
  final TextEditingController _topicNameController = TextEditingController();
  DateTime _selectedDateStart = DateTime.now();
  DateTime _selectedDateEnd = DateTime.now();
  String? uid = FirebaseAuth.instance.currentUser!.uid;

   int? color = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(90, 133, 215, 1),
      ),
      backgroundColor: Colors.white,
      body: Container(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20,),
              Text(
                "Add HomeWork ",
                style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),
              ),
              MyInputField(
                title: "Subject",
                hint: "Enter your Subject",
                controller: _subjectNameController,
              ),
              SizedBox(height: 20,),
              MyInputField(
                title: "Topic",
                hint: "Enter your Topic",
                controller: _topicNameController,
              ),
              SizedBox(height: 20,),
              Row(
                children: [
                  Expanded(
                    child: MyInputField(
                      title: "Assign-Date",
                      hint: DateFormat.yMd().format(_selectedDateStart),
                      widget: IconButton(
                        icon:  Icon(
                          Icons.calendar_today_outlined,
                          color:  Colors.blue.shade300,
                        ),
                        onPressed: () {
                          print("Hi");
                          _getDateFromUser();
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  Expanded(
                    child: MyInputField(
                      title: "Last-Date",
                      hint: DateFormat.yMd().format(_selectedDateEnd),
                      widget: IconButton(
                        icon:  Icon(
                          Icons.calendar_today_outlined,
                          color: Colors.blue.shade300,
                        ),
                        onPressed: () {
                          print("Hi");
                          _getDateFromUser1();
                        },
                      ),
                    ),
                  ),

                ],

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
                      MyButton(label: "Create HomeWork", onTap: () => _validateDate())
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
  _getDateFromUser() async {
    DateTime? _pickerDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015),
        lastDate: DateTime(2121));

    if (_pickerDate != null) {
      setState(() {
        _selectedDateStart = _pickerDate;
        print(_selectedDateStart);
      });
    } else {
      print("it's null or soneting is wrong");
    }
  }
  _getDateFromUser1() async {
    DateTime? _pickerDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015),
        lastDate: DateTime(2121));

    if (_pickerDate != null) {
      setState(() {
        _selectedDateEnd = _pickerDate;
        print(_selectedDateEnd);
      });
    } else {
      print("it's null or soneting is wrong");
    }
  }
  _validateDate() {
    if (_subjectNameController.text.isNotEmpty && _topicNameController.text.isNotEmpty) {
      _addHomework();
      Get.back();
    } else if (_subjectNameController.text.isEmpty || _topicNameController.text.isEmpty) {
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
    final topic = _topicNameController.text;

    if (subject.isEmpty) {
      print('title cannot be empty');
      return;
    }
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    var assignmentRef = firestore.collection('users').doc(uid).collection('Assignment').doc();
    await assignmentRef.set({
    "subjectName": subject,
    "topicName": topic,
    "assignDate": Timestamp.fromDate(_selectedDateStart),
    "lastDate": Timestamp.fromDate(_selectedDateEnd),
      "status" : "Pending",
    "color" : color,
    'AssignmentId': assignmentRef.id,
    });
    if (mounted) {
      Navigator.pop<bool>(context, true);
    }
  }
}
