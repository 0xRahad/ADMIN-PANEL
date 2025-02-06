import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class AppTheme {
  AppTheme._();
  static ThemeData themeData = ThemeData().copyWith(
      scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      color: Colors.white,
    ),
    drawerTheme: DrawerThemeData(
      backgroundColor: Colors.white
    ),
    textTheme: GoogleFonts.urbanistTextTheme()
  );
}