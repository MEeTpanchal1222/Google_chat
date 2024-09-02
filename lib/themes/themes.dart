import 'package:flutter/material.dart';

class AppThemes {
  static final  lightTheme = ThemeData(
    primaryColor: Colors.blue,
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
    centerTitle: true,
    elevation: 1,
    iconTheme: IconThemeData(color: Colors.black),
    titleTextStyle: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.normal,
        fontSize: 19),
    backgroundColor: Colors.white54,
  ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.white
    ),
    colorScheme: ColorScheme.light(
      surface: Colors.grey.shade300,
      primary: Colors.grey.shade500,
      secondary: Colors.grey.shade200,
      tertiary: Colors.white,
      inversePrimary: Colors.grey.shade300,
    ),
  );

   static final darkTheme = ThemeData(
    primaryColor: Colors.white54,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Colors.black45,
    appBarTheme: AppBarTheme(
      color: Colors.black,
      iconTheme: IconThemeData(color: Colors.white),
    ),
       floatingActionButtonTheme: FloatingActionButtonThemeData(
           backgroundColor: Color(0xff06547e),
       ),
     colorScheme: ColorScheme.dark(
       surface: Colors.grey.shade900,
       primary: Colors.grey.shade600,
       secondary: const Color.fromARGB(255,57,57,57),
       tertiary: Colors.grey.shade800,
       inversePrimary: Colors.grey.shade300,
     ),
  );
}
