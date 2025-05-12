import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart'; // google_nav_bar: ^5.0.6

class appbar extends StatefulWidget {
  const appbar({Key? key}) : super(key: key);

  @override
  State<appbar> createState() => _appbarState();
}

class _appbarState extends State<appbar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hello Name......'),
        backgroundColor: Colors.blue.shade800,
        actions: [
          IconButton(onPressed: () {}
              , icon: Icon(Icons.account_box))
        ],
      ),
      bottomNavigationBar: Container(
        color: Colors.blue.shade800,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8),
          child: GNav(
            backgroundColor: Colors.blue.shade800,
            activeColor: Colors.white,
            color: Colors.white70,
            tabBackgroundColor: Colors.blueAccent.shade400,
            padding: EdgeInsets.all(16),
            gap: 8,
            onTabChange: (value) {
              print(value);
            },
            tabs: const[
              GButton(
                icon: Icons.home,
                text: 'Home',
              ),
              GButton(
                icon: Icons.school,
                text: 'Schedule',
              ),
              GButton(
                icon: Icons.access_time_filled_sharp,
                text: 'Activity',
              ),
              GButton(
                icon: Icons.book,
                text: 'Homework',
              ),
            ],
          )
          ,
        ),
      ),
    );
  }
}
