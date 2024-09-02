import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../../../controler/auth_controller.dart';
import '../../../helper/Google_firebase_services.dart';
import '../../../helper/user_services.dart';
import '../../../modal/user_modal.dart';
import '../widgets/text_field_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';




class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    Auth_Controller signController = Get.find();
    return Scaffold(
      body: SingleChildScrollView(
         scrollDirection: Axis.vertical,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
               SizedBox(
                height: 45.h,
              ),
              SizedBox(
                height: 180.h,
                child: Image.asset(
                  'assets/Google_chat.png',
                  fit: BoxFit.cover,
                ),
              ),
               SizedBox(
                height: 20.h,
              ),
              Text(
                'Sign up for free',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 26.h,
                ),
              ),
               SizedBox(
                height: 20.h,
              ),
              SignTextField(
                hintText: 'User name',
                prefixIcon: const Icon(Icons.person_2_outlined),
                controller: signController,
                textEditingController: signController.txtUser,
              ),
              SignTextField(
                hintText: 'Email id',
                prefixIcon: const Icon(Icons.email_outlined),
                controller: signController,
                textEditingController: signController.txtCreateMail,
              ),
              SignTextField(
                hintText: 'Phone',
                prefixIcon: const Icon(Icons.phone),
                controller: signController,
                textEditingController: signController.txtPhone,
              ),
              SignTextField(
                hintText: 'Password ',
                prefixIcon: const Icon(Icons.password),
                controller: signController,
                textEditingController: signController.txtCreatePwd,
              ),
               SizedBox(
                height: 15.h,
              ),
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 40.0).h,
                child: GestureDetector(
                  onTap: () async {
                    Map userModal={
                      'username':signController.txtUser.text,
                      'email':signController.txtCreateMail.text,
                      'photoUrl':GoogleFirebaseServices.googleFirebaseServices.googleSignIn.currentUser?.photoUrl,
                      'phone': signController.txtPhone.text
                    };
                    UserModal user = UserModal(userModal);
                    UserService.userSarvice.addUser(user);
                    //Get.toNamed("/home");
                    Fluttertoast.showToast(
                        msg: (signController.error.value.isNotEmpty ||
                            signController.pwd.value.isNotEmpty)
                            ? signController.error.value.isNotEmpty
                            ? signController.error.value
                            : signController.pwd.value
                            : 'SuccessFully Register',
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: (signController.error.value.isNotEmpty ||
                            signController.pwd.value.isNotEmpty )
                            ? Colors.redAccent
                            : Colors.green.withOpacity(0.7),
                        textColor: Colors.white,
                        fontSize: 16.0.sp);
                    GoogleFirebaseServices.googleFirebaseServices.SignUpPage(email :signController.txtCreateMail.text,password: signController.txtCreatePwd.text,mobile:signController.txtPhone.text,name: signController.txtUser.text, image: GoogleFirebaseServices.googleFirebaseServices.auth.currentUser!.photoURL.toString());


                  },
                  child: Container(
                    width: 230.h,
                    height: 40.h,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        boxShadow:  [
                          BoxShadow(
                            color: Color(0x3F000000),
                            blurRadius: 4.r,
                            offset: Offset(0, 4),
                            spreadRadius: 0,
                          )
                        ],
                        color: const Color(0xff3182c4),
                        borderRadius: BorderRadius.circular(25).r),
                    child: Text(
                      'Sign Up',
                      style: TextStyle(fontSize: 17.sp, color: Colors.white),
                    ),
                  ),
                ),
              ),
               SizedBox(
                height: 10.h,
              ),
                   Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                   Text(
                    'Did You have an Account?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Get.toNamed("/signin");
                    },

                    child: Text(
                      "Sign in",
                      textAlign: TextAlign.center,
                      style:  TextStyle(
                        fontSize: 18.sp,
                        color: Color(0xff3182c4),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
               SizedBox(
                height: 25.h,
                child: Center(child: Text("OR",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 15.h),)),
              ),
              ElevatedButton.icon(
                onPressed: () async {
                  String status = await GoogleFirebaseServices.googleFirebaseServices
                      .signInWithGoogle();
                  Fluttertoast.showToast(msg: status);
                  if (status == 'Suceess') {
                    Get.offAndToNamed('/home');

                  }
                },
                icon: Image.asset('assets/icons/GOOGLE.png',height: 40.h,),
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