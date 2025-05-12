import 'dart:math';

import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobileapp/Widget/inputfield.dart';

class AddActivity extends StatefulWidget {
  const AddActivity({Key? key}) : super(key: key);

  @override
  State<AddActivity> createState() => _AddActivityState();
}

class _AddActivityState extends State<AddActivity> {
  TextEditingController _event = TextEditingController();
  TextEditingController _title = TextEditingController();
  TextEditingController _startdate = TextEditingController();
  TextEditingController _enddate = TextEditingController();
  TextEditingController _starttime = TextEditingController();
  TextEditingController _endtime = TextEditingController();
  TextEditingController _description = TextEditingController();
  TimeOfDay _starttime1 = TimeOfDay.now();
  TimeOfDay _endtime1 = TimeOfDay.now();
  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now();




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:  Color.fromRGBO(90, 133, 215, 1),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Add Activity',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.black),)
              ],
            ),
            Center(
              child: Column(

                children: [
                  Padding(
                    padding:  const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                    child: InputField(
                        controller: _event,
                        label: 'Event'),
                  ),
                  Padding(
                    padding:  const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                    child: InputField(
                        controller: _title,
                        label: 'Title'),
                  ),
                  Padding(
                    padding:  const EdgeInsets.symmetric(horizontal: 10,vertical: 24),
                    child: Row(
                      children: [
                        Expanded(
                          child: InputField(
                              controller: _startdate,
                              label: 'Star Date',
                            onTap: (){
                              _selectDate(context,true);

                            },
                          ),
                        ),
                        SizedBox(width: 20,),
                        Expanded(
                          child: InputField(
                            controller: _enddate,
                            label: 'End Date',
                            onTap: (){
                              _selectDate(context,false);

                            },
                          ),
                        ),
                      ],
                    ),

                  ),
                  Padding(
                    padding:  const EdgeInsets.symmetric(horizontal: 10,vertical: 24),
                    child: Row(
                      children: [
                        Expanded(
                          child: InputField(
                            controller: _starttime,
                            label: 'Star Time',
                            onTap: (){
                              _selectTime(context,true);

                            },
                          ),
                        ),
                        SizedBox(width: 20,),
                        Expanded(
                          child: InputField(
                            controller: _endtime,
                            label: 'End Time',
                            onTap: (){
                              _selectTime(context,false);

                            },
                          ),
                        ),
                      ],
                    ),

                  ),
                  Padding(
                    padding:  const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                    child: InputField(
                        controller: _description,
                        label: 'Description',
                       line:  3,
                    ),
                  ),

                ],

              ),
            )
          ],
          
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final event = CalendarEventData(
              title: _title.text,
              event :  _event.text ,
              description :  _description.text ,
              date: _startDate,
              endDate : _endDate,
            startTime: DateTime(_startDate.year,_startDate.month,_startDate.day,_starttime1.hour,_starttime1.minute),
            endTime: DateTime(_endDate.year,_endDate.month,_endDate.day,_endtime1.hour,_endtime1.minute),
          );

          CalendarControllerProvider.of(context).controller.add(event);
          Navigator.of(context).pop();

        },
        backgroundColor: Color.fromRGBO(90, 133, 215, 1),
        child: Icon(Icons.add,color: Colors.white,),

      ),
    );
  }

  Future<void> _selectTime(BuildContext context,bool time) async {
    final setTime = time ? _starttime1 : _endtime1;
    final TimeOfDay? pickedTime = await showTimePicker(context: context, initialTime: setTime);

    if (pickedTime != null && pickedTime != setTime) {
      setState(() {
        if(time) {
          _starttime1 = pickedTime;
          _starttime.text = pickedTime.format(context).toString();
        }else {
          _endtime1 = pickedTime;
          _endtime.text = pickedTime.format(context).toString();
        }
      });
    }
  }

  Future<void> _selectDate(BuildContext context, bool date) async {
    final setTime = date ? _startDate : _endDate;
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2023,1,1),
        lastDate: DateTime(2030,12,31),);

    if (pickedDate != null && pickedDate != setTime) {
      setState(() {
        if (date) {
          _startDate = pickedDate;
          _startdate.text = DateFormat.yMMMd().format(pickedDate);
        }else {
          _endDate = pickedDate;
          _enddate.text = DateFormat.yMMMd().format(pickedDate);
        }
      });
    }
  }
}
