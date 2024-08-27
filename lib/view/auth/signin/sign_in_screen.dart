
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controler/auth_controller.dart';
import '../../../helper/Google_firebase_services.dart';
import '../../../helper/user_services.dart';
import '../../../main.dart';
import '../../../modal/user_modal.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../widgets/text_field_widget.dart';
import '../../../controler/AnimationController.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {

    mq = MediaQuery.of(context).size;
    final Auth_Controller auth_controller = Get.put(Auth_Controller());
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 35,
              ),
          SizedBox(
                height: mq.height*.25,
                child: Image.asset(
                  'assets/Google_chat.png',
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const Text(
                'Sign in to your Account',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 26,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              SignTextField(
                hintText: 'Email id',
                prefixIcon: const Icon(Icons.email_outlined),
                controller: auth_controller,
                textEditingController: auth_controller.txtEmail,
              ),
              SignTextField(
                hintText: 'Password',
                prefixIcon: const Icon(Icons.password),
                controller: auth_controller,
                textEditingController: auth_controller.txtPwd,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50.0),
                child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'Forgot Password',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey.shade400),
                    )),
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: GestureDetector(
                  onTap: () {
                    GoogleFirebaseServices.googleFirebaseServices
                        .compareEmailAndPwd(auth_controller.txtEmail.text,
                        auth_controller.txtPwd.text);
                    Map userModal={
                      'username':auth_controller.txtUser.text,
                      'email':auth_controller.txtCreateMail.text
                    };

                    UserModal user = UserModal(userModal);
                    UserService.userSarvice.addUser(user);
                  },
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x3F000000),
                            blurRadius: 4,
                            offset: Offset(0, 4),
                            spreadRadius: 0,
                          )
                        ],
                        color: const Color(0xff31C48D),
                        borderRadius: BorderRadius.circular(25)),
                    child: const Text(
                      'Sign In',
                      style: TextStyle(fontSize: 17, color: Colors.white),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 35,
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
                icon: Image.asset('assets/icons/GOOGLE.png',height: 50,),
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
              ),
              // const GoogleAndAppleSignin(
              //   sign: 'Sign Up',
              // ),
            ],
          ),
        ),
      ),
    );
  }
}