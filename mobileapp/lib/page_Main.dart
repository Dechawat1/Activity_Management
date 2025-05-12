import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:mobileapp/HomeScreen.dart';
import 'package:mobileapp/Screen/Activity.dart';
import 'package:mobileapp/Screen/HomeWork.dart';

import 'Screen/Schedule.dart';
import 'Screen/assignment_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  List pages = [ HomeScreen(), ScheduleScreen(), ActivityScreen(),  AssignmentScreen(),HomeWorkScreem()];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Container(

            color: Color.fromRGBO(79, 109, 166, 1),
          child: Padding(

            padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8),
            child: GNav(

               backgroundColor: Color.fromRGBO(79, 109, 166, 1),
                activeColor: Colors.white,
               color: Colors.white,
               tabBackgroundColor: Colors.blue.shade100,
              padding: const EdgeInsets.all(16),
              gap: 32,
              onTabChange: (int index) {
                setState(() {
                  _selectedIndex = index;
                });
                // setState(
                //       () {
                //     _selectedIndex = index;
                //     if(_selectedIndex == 0) {
                //       Navigator.push(context,
                //           MaterialPageRoute(
                //               builder: (context) {
                //                 return  HomeScreen();
                //               }));
                //     } else if (_selectedIndex == 1){
                //       Navigator.push(context,
                //           MaterialPageRoute(
                //               builder: (context) {
                //                 return const ScheduleScreen();
                //               }));
                //     }else if (_selectedIndex == 2){
                //       Navigator.push(context,
                //           MaterialPageRoute(
                //               builder: (context) {
                //                 return const ActivityScreen();
                //               }));
                //     }else if (_selectedIndex == 3){
                //       Navigator.push(context,
                //           MaterialPageRoute(
                //               builder: (context) {
                //                 return const HomeWorkScreem();
                //               }));
                //     }else if (_selectedIndex == 4){
                //       Navigator.push(context,
                //           MaterialPageRoute(
                //               builder: (context) {
                //                 return const AssignmentScreen();
                //               }));
                //     }else if (_selectedIndex == 5){
                //       Navigator.push(context,
                //           MaterialPageRoute(
                //               builder: (context) {
                //                 return const AssignmentScreen();
                //               }));
                //     }
                //   },
                // );
              } ,

              tabs: [
                GButton(

                  icon: CommunityMaterialIcons.home_city,
                  text: 'Home',
                ),
                GButton(
                  icon: CommunityMaterialIcons.school,
                  text: 'Schedule',
                ),
                GButton(
                  icon: CommunityMaterialIcons.table,
                  text: 'Activity',
                ),
                GButton(
                  icon: Icons.assignment_ind,
                  text: 'Assignment',
                ),
                GButton(
                  icon: CommunityMaterialIcons.note,
                  text: 'Notes',
                ),


              ],
            )
            ,
          ),
        ),
      ),
    );
  }
}
