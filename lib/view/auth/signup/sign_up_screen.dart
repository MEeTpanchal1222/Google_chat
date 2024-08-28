import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../../../controler/auth_controller.dart';
import '../../../helper/Google_firebase_services.dart';
import '../widgets/text_field_widget.dart';



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
              const SizedBox(
                height: 45,
              ),
              SizedBox(
                height: 200,
                child: Image.asset(
                  'assets/Google_chat.png',
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const Text(
                'Sign up for free',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 26,
                ),
              ),
              const SizedBox(
                height: 30,
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
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: GestureDetector(
                  onTap: () async {
                    GoogleFirebaseServices.googleFirebaseServices.createEmailAndPassword(signController.txtCreateMail.text, signController.txtCreatePwd.text);
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
                        fontSize: 16.0);


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
                        color: const Color(0xff3182c4),
                        borderRadius: BorderRadius.circular(25)),
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(fontSize: 17, color: Colors.white),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
                   Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Did You have an Account?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
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
                      style: const TextStyle(
                        fontSize: 18,
                        color: Color(0xff3182c4),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 35,
                child: Center(child: Text("OR",style: TextStyle(fontWeight: FontWeight.w700),)),
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
            ],
          ),
        ),
      ),
    );
  }
}