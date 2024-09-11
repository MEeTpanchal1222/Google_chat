 import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
 import 'package:firebase_core/firebase_core.dart';
import 'package:google_chat/view/Ai_chat_screen/Ai_chat_screen.dart';
import 'package:google_chat/view/auth/signin/sign_in_screen.dart';
import 'package:google_chat/view/auth/signup/sign_up_screen.dart';
import 'package:google_chat/view/chatpage/chatpage.dart';
import 'package:google_chat/view/otp/otp_screen.dart';
import 'package:google_chat/view/otp_verify/otp_verify.dart';
 import 'firebase_options.dart';
 import 'package:flutter_screenutil/flutter_screenutil.dart';
 import 'package:google_chat/themes/themes.dart';
import 'controler/theme_controler.dart';
 import 'package:flutter_gemini/flutter_gemini.dart';
import 'helper/Api_scrvices.dart';
import 'helper/Firebase_Messaging_services.dart';
import 'helper/Notification_services.dart';
import 'helper/auth_gate.dart';
import 'view/auth/login_screen/login_screen.dart';
 import 'package:get/get.dart';
 import 'package:firebase_messaging/firebase_messaging.dart';
import 'view/home_screen/home_screen.dart';

 @pragma('vm:entry-point')
 Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
   if (kDebugMode) {
     print("Handling a background message: ${message.notification!.title}");
   }
   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
   // Get.to(const UserPage());
 }
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Gemini.init(apiKey: 'AIzaSyAwWJE4--FNbdaZrjynNKjqvrZy7p4kaMk');
  NotificationServices.notificationServices.initNotification();
  await FirebaseMessagingServices.firebaseMessagingServices.requestPermission();
  await FirebaseMessagingServices.firebaseMessagingServices.generateDeviceToken();
  //ApiService.apiService.getServerToken();
  FirebaseMessagingServices.firebaseMessagingServices.onMessageListener();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    ThemeController themeController = Get.put(ThemeController());
    return ScreenUtilInit(
      builder: (context, child) => Obx(
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
                  page: () =>
                      AuthGate(),
                      //LoginScreen()

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
                GetPage(name: "/Aichat",
                    page: () => AiChatScreen())
              ],
      ),
      ),
    );
  } 
}

