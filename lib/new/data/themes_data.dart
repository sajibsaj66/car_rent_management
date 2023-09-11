import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData lightModeTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: Colors.black,
  secondaryHeaderColor: Colors.blue.shade900,
  textTheme: TextTheme(
    bodyMedium: GoogleFonts.poppins(color: Colors.black),
  ),
  cardColor: Colors.white,
);
ThemeData darkModeTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: Colors.black,
  secondaryHeaderColor: const Color(0xff3b22a1),
  textTheme: TextTheme(
    bodyMedium: GoogleFonts.poppins(color: Colors.white),
  ),
  cardColor: const Color(0xff070606),
);
