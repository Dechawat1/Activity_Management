import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  InputField(
      {Key? key,
      required this.controller,
      required this.label,
      this.line = 1,
      this.onTap})
      : super(key: key);

  TextEditingController controller;
  String label;
  int line;
  Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLines: line,
      onTap: onTap,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(8),
        labelText: label,
        labelStyle: const TextStyle(
            color: Colors.black45,
            fontSize:  20,
            fontWeight: FontWeight.bold),
        border: OutlineInputBorder(
        ),
      ),

    );
  }
}
