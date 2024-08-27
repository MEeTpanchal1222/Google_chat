import 'package:flutter/material.dart';
import 'package:google_chat/main.dart';
import 'package:get/get.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../controler/AnimationController.dart';
import '../../../helper/Google_firebase_services.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  @override
  Widget build(BuildContext context) {
    final AnimationControl animController = Get.put(AnimationControl());
    mq = MediaQuery.of(context).size;
    return Scaffold(
        appBar:  AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Welcome  To  Google Chat",),),
      body: Stack(
        children: [
          AnimatedPositioned(
            top: mq.height*.15,
              right:animController.isAnimated.value? mq.width*.25: mq.width*.5,
              width: mq.width*.5,
              duration: Duration(seconds: 1 ),
              child: Image.asset('assets/Google_chat.png')),
          Positioned(
              bottom: mq.height*.18,
              left: mq.width*.09,
              width: mq.width*.8,
              height: mq.height*.07,
              child: ElevatedButton.icon(
                onPressed: () async {
                  String status = await GoogleFirebaseServices.googleFirebaseServices
                      .signInWithGoogle();
                  Fluttertoast.showToast(msg: status);
                  if (status == 'Suceess') {
                    Get.offAndToNamed('/home');
                  }
                },
                  icon: Image.asset('assets/icons/GOOGLE.png',height: mq.height*05,),
                 label: RichText(
                   text: TextSpan(
                     style: TextStyle(color: Colors.black,fontSize:19),
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
              bottom: mq.height*.10,
              left: mq.width*.09,
              width: mq.width*.8,
              height: mq.height*.07,
              child: ElevatedButton.icon(
                onPressed: () {
                    Get.toNamed("/signin");
                },
                icon: Padding(
                  padding: const EdgeInsets.all(2),
                  child: Image.asset('assets/icons/envelope.png',height: mq.height*.2,width: mq.width*.12,),
                ),
                label: RichText(
                  text: TextSpan(
                      style: TextStyle(color: Colors.black,fontSize:19),
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
    );
  }
}
