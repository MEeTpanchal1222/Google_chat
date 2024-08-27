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
    )
  );

   static final darkTheme = ThemeData(
    primaryColor: Colors.black,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: AppBarTheme(
      color: Colors.black,
      iconTheme: IconThemeData(color: Colors.white),
    ),
       floatingActionButtonTheme: FloatingActionButtonThemeData(
           backgroundColor: Colors.black54
       )
  );
}
