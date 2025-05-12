import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobileapp/Screen_colors/addActivity.dart';
import 'package:table_calendar/table_calendar.dart';
import '../Screen_colors/edit_event.dart';
import '../Widget/event_item.dart';
import '../models/event.dart';
import '../Widget/add_event.dart';

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({Key? key}) : super(key: key);

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  late DateTime _focusedDay;
  late DateTime _firstDay;
  late DateTime _lastDay;
  late DateTime _selectedDay;
  late CalendarFormat _calendarFormat;
  late Map<DateTime, List<Event>> _events;
  String? uid = FirebaseAuth.instance.currentUser!.uid;
  CollectionReference? eventRef;

  var firebaseUser = FirebaseAuth.instance.currentUser;
  CollectionReference? eventref;

  int getHashCode(DateTime key) {
    return key.day * 1000000 + key.month * 10000 + key.year;
  }

  @override
  void initState() {
    eventref = FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('Notes');

    super.initState();
    _events = LinkedHashMap(
      equals: isSameDay,
      hashCode: getHashCode,
    );
    _focusedDay = DateTime.now();
    _firstDay = DateTime.now().subtract(const Duration(days: 1000));
    _lastDay = DateTime.now().add(const Duration(days: 1000));
    _selectedDay = DateTime.now();
    _calendarFormat = CalendarFormat.month;
    _loadFirestoreEvents();
  }

  _loadFirestoreEvents() async {
    final firstDay = DateTime(_focusedDay.year, _focusedDay.month, 1);
    final lastDay = DateTime(_focusedDay.year, _focusedDay.month + 1, 0);
    _events = {};

    final snap = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('Activity')
        .where('date', isGreaterThanOrEqualTo: firstDay)
        .where('date', isLessThanOrEqualTo: lastDay)
        .withConverter(
            fromFirestore: Event.fromFirestore,
            toFirestore: (event, options) => event.toFirestore())
        .get();
    for (var doc in snap.docs) {
      final event = doc.data();
      final day =
          DateTime.utc(event.date.year, event.date.month, event.date.day);
      if (_events[day] == null) {
        _events[day] = [];
      }
      _events[day]!.add(event);
    }
    setState(() {});
  }

  List _getEventsForTheDay(DateTime day) {
    return _events[day] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(79, 109, 166, 1),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromRGBO(79, 109, 166, 1),
        centerTitle: true,
        title: Text('Activity  ',style: TextStyle(color: Colors.white,),),
      ),
      body: ListView(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  height: 50,
                  width: 450,
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            alignment: Alignment.topLeft,
                            height: 60,
                            width: 60,
                            child: Image.asset('assets/activity.png'),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text('List Activity',style: TextStyle(fontSize: 17,fontWeight: FontWeight.w500),),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Card(
            child: TableCalendar(
              locale: 'en_US',
              startingDayOfWeek: StartingDayOfWeek.monday,
              eventLoader: _getEventsForTheDay,
              calendarFormat: _calendarFormat,
              onFormatChanged: (format) {
                setState(() {
                  _calendarFormat = format;
                });
              },
              focusedDay: _focusedDay,
              firstDay: _firstDay,
              lastDay: _lastDay,
              onPageChanged: (focusedDay) {
                setState(() {
                  _focusedDay = focusedDay;
                });
                _loadFirestoreEvents();
              },
              selectedDayPredicate: (day) => isSameDay(day, _selectedDay),
              onDaySelected: (selectedDay, focusedDay) {
                print(_events[selectedDay]);
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
              },
              calendarStyle: CalendarStyle(
                cellAlignment: Alignment.center,
                cellPadding: EdgeInsets.all(4.0),
                cellMargin: EdgeInsets.all(8.0),
                markerSize: 7.0,
                markerDecoration:
                    BoxDecoration(shape: BoxShape.circle, color: Colors.black),
                todayDecoration: BoxDecoration(
                    shape: BoxShape.circle, color: Colors.blue.shade300),
                weekendTextStyle: TextStyle(color: Colors.black, fontSize: 14),
                selectedDecoration: BoxDecoration(
                  border: Border.all(color: Colors.blueAccent),
                  shape: BoxShape.circle,
                  color: Colors.blueAccent,
                ),
              ),
              daysOfWeekStyle: DaysOfWeekStyle(
                  weekdayStyle: TextStyle(
                      color: Color.fromRGBO(90, 133, 215, 1),
                      fontWeight: FontWeight.w500,
                      fontSize: 15),
                  weekendStyle: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.w500,
                      fontSize: 15)),
              headerStyle: HeaderStyle(
                  decoration: BoxDecoration(
                    color: Colors.blue.shade300,
                  ),
                  headerMargin: EdgeInsets.only(bottom: 8.0),
                  titleTextStyle: TextStyle(color: Colors.white, fontSize: 18),
                  formatButtonDecoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  formatButtonTextStyle: TextStyle(color: Colors.white),
                  leftChevronIcon: Icon(
                    Icons.chevron_left,
                    color: Colors.white,
                  ),
                  rightChevronIcon: Icon(
                    Icons.chevron_right,
                    color: Colors.white,
                  )),
            ),
          ),
          SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(left: 30),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.55,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50), topRight: Radius.circular(50)),
                color: Color.fromRGBO(90, 133, 215, 1),
              ),
              child: Stack(
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 50),
                        child: Text(
                          "Today ! ",
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 8),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.only(left: 10, right: 10),
                                width: MediaQuery.of(context).size.width * 0.9,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    ..._getEventsForTheDay(_selectedDay).map(
                                          (event) => EventItem(
                                          event: event,
                                          onTap: () async {
                                            final res = await Navigator.push<bool>(
                                              context,
                                              MaterialPageRoute(
                                                builder: (_) => EditEvent(
                                                    firstDate: _firstDay,
                                                    lastDate: _lastDay,
                                                    event: event),
                                              ),
                                            );
                                            if (res ?? false) {
                                              _loadFirestoreEvents();
                                            }
                                          },
                                          onDelete: () async {
                                            final delete = await showDialog<bool>(
                                              context: context,
                                              builder: (_) => AlertDialog(
                                                title: const Text("Delete Event?"),
                                                content: const Text("Are you sure you want to delete?"),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () => Navigator.pop(context, false),
                                                    style: TextButton.styleFrom(
                                                      foregroundColor: Colors.black,
                                                    ),
                                                    child: const Text("No"),
                                                  ),
                                                  TextButton(
                                                    onPressed: () => Navigator.pop(context, true),
                                                    style: TextButton.styleFrom(
                                                      foregroundColor: Colors.red,
                                                    ),
                                                    child: const Text("Yes"),
                                                  ),
                                                ],
                                              ),
                                            );
                                            if (delete ?? false) {
                                              await FirebaseFirestore.instance
                                                  .collection('users')
                                                  .doc(uid)
                                                  .collection('Activity')
                                                  .doc(event.id)
                                                  .delete();
                                              // await FirebaseFirestore.instance
                                              //     .collection('events')
                                              //     .doc(event.id)
                                              //     .delete();
                                              _loadFirestoreEvents();
                                            }
                                          }),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue.shade100,
        onPressed: () async {
          final result = await Navigator.push<bool>(
            context,
            MaterialPageRoute(
              builder: (_) => AddEvent(
                firstDate: _firstDay,
                lastDate: _lastDay,
                selectedDate: _selectedDay,
              ),
            ),
          );
          if (result ?? false) {
            _loadFirestoreEvents();
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
