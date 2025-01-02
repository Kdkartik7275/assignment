import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:internship_assignment/core/utils/constants/colors.dart';

class TTheme {
  static ThemeData lightTheme = ThemeData(
    primaryColor: TColors.lightPrimary,
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: TColors.lightAccent,
    ),
    scaffoldBackgroundColor: TColors.lightBG,
    bottomAppBarTheme: BottomAppBarTheme(
      elevation: 0,
      color: TColors.lightBG,
    ),
    appBarTheme: AppBarTheme(
      elevation: 0.0,
      backgroundColor: TColors.lightBG,
      iconTheme: const IconThemeData(color: Colors.black),
      toolbarTextStyle: GoogleFonts.nunito(
        color: Colors.black,
        fontSize: 20.0,
        fontWeight: FontWeight.w700,
      ),
      titleTextStyle: GoogleFonts.nunito(
        color: Colors.black,
        fontSize: 20.0,
        fontWeight: FontWeight.w700,
      ),
    ),
    colorScheme: ColorScheme.fromSwatch().copyWith(
      secondary: TColors.lightAccent,
    ),
  );
}
