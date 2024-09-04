// import 'package:flutter/material.dart';
//
// class AppThemes {
//   static final  lightTheme = ThemeData(
//     primaryColor: Colors.blue,
//     brightness: Brightness.light,
//     appBarTheme: const AppBarTheme(
//     centerTitle: true,
//     elevation: 1,
//     iconTheme: IconThemeData(color: Colors.black),
//     titleTextStyle: TextStyle(
//         color: Colors.black,
//         fontWeight: FontWeight.normal,
//         fontSize: 19),
//     backgroundColor: Colors.white54,
//   ),
//     floatingActionButtonTheme: FloatingActionButtonThemeData(
//       backgroundColor: Colors.white
//     ),
//     colorScheme: ColorScheme.light(
//       surface: Colors.grey.shade300,
//       primary: Colors.grey.shade500,
//       secondary: Colors.grey.shade200,
//       tertiary: Colors.white,
//       inversePrimary: Colors.grey.shade300,
//       background:Colors.grey.shade200,
//     ),
//   );
//
//    static final darkTheme = ThemeData(
//     primaryColor: Colors.white54,
//
//     brightness: Brightness.dark,
//     appBarTheme: AppBarTheme(
//       color: Colors.black,
//       iconTheme: IconThemeData(color: Colors.white),
//     ),
//        floatingActionButtonTheme: FloatingActionButtonThemeData(
//            backgroundColor: Color(0xff06547e),
//        ),
//      colorScheme: ColorScheme.dark(
//        surface: Color(0xff06547e),
//        primary: Colors.grey.shade600,
//        secondary: const Color.fromARGB(255,57,57,57),
//        tertiary: Colors.grey.shade800,
//        inversePrimary: Colors.grey.shade300,
//
//      ),
//   );
// }


import 'package:flutter/material.dart';

class AppThemes {
  static final lightTheme = ThemeData(
    primaryColor: Colors.blue,
    brightness: Brightness.light,
    appBarTheme:  AppBarTheme(
      centerTitle: true,
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.black87),
      titleTextStyle: TextStyle(
        color: Colors.black87,
        fontWeight: FontWeight.w500,
        fontSize: 20,
      ),
      backgroundColor: Colors.grey.shade200,
    ),
    floatingActionButtonTheme:  FloatingActionButtonThemeData(
      backgroundColor: Colors.blue.shade50,
    ),
    colorScheme: ColorScheme.light(
      surface: Colors.grey.shade200,
      primary: Colors.black87,
      secondary: Colors.blue.shade100,
      tertiary: Colors.white,
      inverseSurface: Colors.blue.shade50,
      inversePrimary: Colors.blueAccent,
    ),
    scaffoldBackgroundColor: Colors.white,
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.black87),
      bodyMedium: TextStyle(color: Colors.black54),
    ),
  );

  static final darkTheme = ThemeData(
    primaryColor: Colors.blueGrey,
    brightness: Brightness.dark,
    appBarTheme: const AppBarTheme(
      color: Colors.black,
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.white),
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w500,
        fontSize: 20,
      ),
    ),
    floatingActionButtonTheme:  FloatingActionButtonThemeData(
      backgroundColor: Color(0xff06547e),
    ),
    colorScheme: ColorScheme.dark(
      surface: Color(0xff1c1c1e),
      primary: Colors.blueGrey,
      secondary: Color(0xff06547e),
      tertiary: Colors.grey.shade400,
      inversePrimary: Colors.blue.shade300,
      inverseSurface: Color(0xff06547e),
    ),
    scaffoldBackgroundColor: Colors.black,
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.white),
      bodyMedium: TextStyle(color: Colors.white70),
    ),
  );
}
