
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../controler/auth_controller.dart';
import '../../../helper/Google_firebase_services.dart';
import '../../../helper/user_services.dart';
import '../../../main.dart';
import '../../../modal/user_modal.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../widgets/text_field_widget.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {

    final Auth_Controller auth_controller = Get.put(Auth_Controller());
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 35.h,
              ),
          SizedBox(
                height: 180.h,
                child: Image.asset(
                  'assets/Google_chat.png',
                  fit: BoxFit.cover,
                ),
              ),
               SizedBox(
                height: 30.h,
              ),
               Text(
                'Sign in to your Account',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 26.sp,
                ),
              ),
               SizedBox(
                height: 30.h,
              ),
              SignTextField(
                hintText: 'Email id',
                prefixIcon: const Icon(Icons.email_outlined),
                controller: auth_controller,
                textEditingController: auth_controller.txtEmail,
              ),
              SizedBox(height: 10.h,),
              SignTextField(
                hintText: 'Password',
                prefixIcon: const Icon(Icons.lock_open),
                controller: auth_controller,
                textEditingController: auth_controller.txtPwd,
              ),
              Padding(
                padding:  EdgeInsets.only(left: 25.h,right: 25.h,top: 8.h),
                child: Row(
                  children: [
                    Container(
                      //color: Colors.green,
                      child: Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding:  EdgeInsets.only(left: 10.h,right: 40.h),
                            child: GestureDetector(
                              onTap: () {
                                Get.toNamed("/signup");
                              },
                              child: Text(
                                'New to Google Chat',
                                style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xff3182c4),),
                              ),
                            ),
                          )),
                    ),
                    Container(
                     // color: Colors.redAccent,
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: GestureDetector(
                            onTap: () {
                              Get.toNamed("/otp");
                            },
                            child: Text(
                              'Forgot Password',
                              style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey.shade400),
                            ),
                          )),
                    ),
                  ],
                ),
              ),
               SizedBox(
                height: 35.h,
              ),
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 40.0).h,
                child: GestureDetector(
                  onTap: () {
                    GoogleFirebaseServices.googleFirebaseServices.Signin(auth_controller.txtEmail.text, auth_controller.txtPwd.text);
                    // Map userModal={
                    //   'username':auth_controller.txtUser.text,
                    //   'email':auth_controller.txtCreateMail.text
                    // };
                    //
                    // UserModal user = UserModal(userModal);
                    // UserService.userSarvice.addUser(user);
                  },
                  child: Container(
                    width: 190.h,
                    height: 40.h,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        boxShadow:  [
                          BoxShadow(
                            color: Color(0x3F000000),
                            blurRadius: 4.r,
                            offset: Offset(0, 4),
                            spreadRadius: 0.5,
                          )
                        ],
                        color: const Color(0xff3182c4),
                        borderRadius: BorderRadius.circular(25).r),
                    child:  Text(
                      'Sign In',
                      style: TextStyle(fontSize: 17.h, color: Colors.white),
                    ),
                  ),
                ),
              ),
               SizedBox(
                height: 35.h,
                child: Center(child: Text("OR",style: TextStyle(fontWeight: FontWeight.w700),)),
              ),
              ElevatedButton.icon(
                onPressed: () async {
                  String status = await GoogleFirebaseServices.googleFirebaseServices.signInWithGoogle();

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
              ),
            ],
          ),
        ),
      ),
    );
  }
}