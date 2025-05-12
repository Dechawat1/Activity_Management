import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppStyle{
  static Color bgColor = Color(0xFFe2e2ff);
  static Color mainColor = Color(0xFF80DEEA);
  static Color accentColor = Color(0xFF0065FF);

  static List<Color> cardsColor = [
    Color(0xFF80DEEA),
    Color(0xFF0065FF),
    Colors.purple.shade100,
    Colors.pink.shade100,
    Colors.orange.shade100,
    Colors.blue.shade100,
    Colors.yellow.shade100,
    Colors.green.shade100,

  ];

  static List<Color> textColor = [
    Colors.red,
    Colors.green
  ];


  static TextStyle mainTitle = GoogleFonts.roboto(
    fontWeight: FontWeight.w500,fontSize: 16.0
  );

  static TextStyle mainContent = GoogleFonts.nunito(
      fontWeight: FontWeight.w500,fontSize: 16.0
  );
  static TextStyle dateTitle = GoogleFonts.roboto(
      fontWeight: FontWeight.w500,fontSize: 16.0
  );
}