 import 'package:flutter/material.dart';
import 'package:google_chat/themes/themes.dart';
import 'controler/theme_controler.dart';
import 'view/auth/login_screen/login_screen.dart';
 import 'package:get/get.dart';
import 'view/home_screen/home_screen.dart';

late  Size  mq;
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    ThemeController themeController = Get.put(ThemeController());
    return Obx(
          () =>GetMaterialApp(
            themeMode: themeController.themeMode.value,
            theme: AppThemes.lightTheme,
            darkTheme: AppThemes.darkTheme,
      debugShowCheckedModeBanner: false,
      title: 'Google Chat',
      home: LoginScreen(),
    ),
    );
  }
}

