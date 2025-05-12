

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobileapp/models/eventT1.dart';

class AddEvent extends StatefulWidget {
  final Event? event;
  final DateTime firstDate;
  final DateTime lastDate;
  final DateTime? selectedDate;
  const AddEvent(
      {Key? key,
        required this.firstDate,
        required this.lastDate,
        this.selectedDate,this.event})
      : super(key: key);

  @override
  State<AddEvent> createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  String? uid = FirebaseAuth.instance.currentUser!.uid;
  final _formKey = GlobalKey<FormState>();
  late DateTime fromDate;
  late DateTime toDate;

  late TimeOfDay _selectedTime;
  late DateTime _selectedDate;
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _selectedDate = widget.selectedDate ?? DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Event"),backgroundColor: Color.fromRGBO(90, 133, 215, 1),),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              InputDatePickerFormField(
                firstDate: widget.firstDate,
                lastDate: widget.lastDate,
                initialDate: _selectedDate,
                onDateSubmitted: (date) {
                  print(date);
                  setState(() {
                     _selectedDate = date;
                  });
                },
              ),
              TextField(
                controller: _titleController,
                maxLines: 1,
                decoration: const InputDecoration(labelText: 'title'),
              ),
              TextField(
                controller: _descController,
                maxLines: 5,
                decoration: const InputDecoration(labelText: 'description'),
              ),
              ElevatedButton(
                onPressed: () {
                  _addEvent();
                },
                child: const Text("Save"),
              ),
            ],
          ),
        ),

      ),
    );
  }


  void _addEvent() async {
    final title = _titleController.text;
    final description = _descController.text;

    if (title.isEmpty) {
      print('title cannot be empty');
      return;
    }
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    var activityRef = firestore.collection('users').doc(uid).collection('Activity').doc();
    await activityRef.set({
      "title": title,
      "description": description,
      "date": Timestamp.fromDate(_selectedDate),
      "ActivityId" : activityRef.id,
    });
    // await FirebaseFirestore.instance.collection('users').doc(uid).collection('Activity').doc().set({
    //   "title": title,
    //   "description": description,
    //   "date": Timestamp.fromDate(_selectedDate),
    //   "ActivityId" : document.id,
    // });
    if (mounted) {
      Navigator.pop<bool>(context, true);
    }
  }
}