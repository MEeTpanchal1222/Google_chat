import 'package:flutter/material.dart';
import 'package:google_chat/controler/auth_controller.dart';
import 'package:get/get.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../controler/AnimationController.dart';
import '../../../helper/Google_firebase_services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  @override
  Widget build(BuildContext context) {
    final AnimationControl animController = Get.put(AnimationControl());
    final Auth_Controller auth = Get.put(Auth_Controller());
    return Scaffold(
        appBar:  AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Welcome  To  Google Chat",),),
      body: Obx(
        () => Stack(
          children: [
            AnimatedPositioned(
                top: 100.h,
                right:animController.isAnimated.value? 70.h:15.h,
                width: 180.h,
                duration: Duration(seconds: 1 ),
                child: Image.asset('assets/Google_chat.png')),
            Positioned(
                bottom: 130.h,
                left: 30.h,
                width: 250.h,
                height: 50.h,
                child: ElevatedButton.icon(
                  onPressed: () async {
                    String status = await GoogleFirebaseServices.googleFirebaseServices
                        .signInWithGoogle();
                    Fluttertoast.showToast(msg: status);
                    if (status == 'Suceess') {
                      Get.offAndToNamed('/home');
                    }
                  },
                    icon: Image.asset('assets/icons/GOOGLE.png',height: 50.h,),
                   label: RichText(
                     text: TextSpan(
                       style: TextStyle(color: Colors.black,fontSize:19.sp),
                       children: [
                         TextSpan(text: 'Sign In with '),
                         TextSpan(text: 'Google',
                           style: TextStyle(
                             fontWeight: FontWeight.w700
                           )
                         )
                       ]
                     ),
                   ),
                  style:ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade50

                  ),
                )),
            Positioned(
                bottom: 70.h,
                left: 30.h,
                width: 250.h,
                height: 50.h,
                child: ElevatedButton.icon(
                  onPressed: () {
                      Get.toNamed("/signin");
                  },
                  icon: Padding(
                    padding: const EdgeInsets.all(2).h,
                    child: Image.asset('assets/icons/envelope.png',height: 50.h,width: 40.h,),
                  ),
                  label: RichText(
                    text: TextSpan(
                        style: TextStyle(color: Colors.black,fontSize:19.sp),
                        children: [
                          TextSpan(text: 'Sign In with '),
                          TextSpan(text: 'Email',
                              style: TextStyle(
                                  fontWeight: FontWeight.w700
                              )
                          )
                        ]
                    ),
                  ),
                  style:ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade50

                  ),
                )),
          ],
        ),
      ),
    );
  }
}
