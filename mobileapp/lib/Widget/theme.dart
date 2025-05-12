import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

const Color purpleClr = Color(0xFF5E35B1);
const Color bluishClr = Color(0xFF4e5ae8);
const Color bluishClr2 = Color(0xFF9FA8DA);
const Color bluishClr3 = Color(0xFF7986CB);
const Color greenClr = Color(0xFF689F38);
const Color greenClr1 = Color(0xFFDCEDC8);
const Color greenClr2 = Color(0xFFC5E1A5);
const Color yellowClr1 = Color(0xFFFFD600);
const Color yellowClr = Color(0xFFF57F17);
const Color pinksClr = Color(0xFFff4667);
const Color redClr = Color(0xFFE53935);
const Color cyanClr = Color(0xFF00E5FF);
const Color cyanClr1 = Color(0xFFB2EBF2);
const Color blueClr2 = Color(0xFF81D4FA);

const Color whiteClr = Colors.white;
const primaryClr  = bluishClr;
const Color darkGreyClr = Color(0xFF121212);
const Color darkHeaderClr = Color(0xFF424242);

class ThemesColor {

  static final light =  ThemeData(
      backgroundColor: Colors.white,
      brightness: Brightness.light
  );

  static final dark =  ThemeData(
    backgroundColor: darkGreyClr,
    brightness: Brightness.dark,
  );




}

TextStyle get subHeadingStyle {
  return GoogleFonts.lato (
      textStyle: TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: 18,
          color: Get.isDarkMode?Colors.grey[400]:Colors.black
      )
  );
}


TextStyle get headingStyle {
  return GoogleFonts.lato (
      textStyle: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 30,
          color: Get.isDarkMode?Colors.white:Colors.black
      )
  );
}


TextStyle get titleStyle {
  return GoogleFonts.lato (
      textStyle: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
          color: Get.isDarkMode?Colors.white:Colors.black
      )
  );
}



