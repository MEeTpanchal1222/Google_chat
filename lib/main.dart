 import 'package:flutter/material.dart';
 import 'package:firebase_core/firebase_core.dart';
import 'package:google_chat/view/auth/signin/sign_in_screen.dart';
import 'package:google_chat/view/auth/signup/sign_up_screen.dart';
import 'package:google_chat/view/chatpage/chatpage.dart';
import 'package:google_chat/view/otp/otp_screen.dart';
import 'package:google_chat/view/otp_verify/otp_verify.dart';
 import 'firebase_options.dart';
import 'package:google_chat/themes/themes.dart';
import 'controler/theme_controler.dart';
import 'view/auth/login_screen/login_screen.dart';
 import 'package:get/get.dart';
import 'view/home_screen/home_screen.dart';
 late Size  mq;
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  initializeFirebase();
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
            initialRoute: '/',
            getPages: [
              GetPage(
                name: '/',
                page: () =>  LoginScreen(),
              ),
              GetPage(
                name: '/signin',
                page: () =>  SignInPage(),
                transition: Transition.cupertino,
                transitionDuration: Duration(milliseconds: 500),
              ),
              GetPage(
                name: '/signup',
                page: () =>  SignUpPage(),
                transition: Transition.cupertino,
                transitionDuration: Duration(milliseconds: 500),
              ),
              GetPage(
                name: '/otp',
                page: () => const OtpPage(),
              ),
              GetPage(
                name: '/otpAdd',
                page: () => const OtpVerifyPage(),
              ),
              GetPage(
                name: '/home',
                page: () => const Home_screen(),
              ),
              GetPage(
                name: '/chat',
                page: () =>  ChatPage(),
              ),
            ],
    ),
    );
  }
}

 initializeFirebase() async {
   await Firebase.initializeApp(
     options: DefaultFirebaseOptions.currentPlatform,
   );
 }