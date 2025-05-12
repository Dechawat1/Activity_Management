
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyButton extends StatelessWidget {
  final String label;
  final Function()? onTap;

  const MyButton({Key? key, required this.label, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 145,
        height: 45,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.blue.shade300,
        ),
        padding: EdgeInsets.all(13),
        child: Center(
          child: Text(

            label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,

            ),
          ),
        ),
      ),
    );
  }
}
