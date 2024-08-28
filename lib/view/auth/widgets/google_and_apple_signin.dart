import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../../helper/Google_firebase_services.dart';

class GoogleAndAppleSignin extends StatelessWidget {
  final String sign;

  const GoogleAndAppleSignin({
    super.key,
    required this.sign,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 10,
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
                if (sign == 'Sign Up') {
                  Get.toNamed('/signup');
                } else {
                  Get.back();
                }
              },
              child: Text(
                sign,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 18,
                  color: Color(0xff31C48D),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 30,
        ),
        const Text(
          'Or continue with',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            letterSpacing: 1.5,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () async {
                String status = await GoogleFirebaseServices.googleFirebaseServices
                    .signInWithGoogle();
                Fluttertoast.showToast(msg: status);
                if (status == 'Suceess') {
                  Get.offAndToNamed('/home');

                }
              },
              child: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color(0xffdcddea).withOpacity(0.5),
                  image: const DecorationImage(
                    image: AssetImage('assets/icons/GOOGLE.png'),
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            GestureDetector(
              onTap: () async {},
              child: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color(0xffc5cdee).withOpacity(0.5),
                  image: const DecorationImage(
                    image: AssetImage('asset/sign in/facebook.png'),
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color(0xffc5cdee).withOpacity(0.5),
                image: const DecorationImage(
                  image: AssetImage('asset/sign in/apple.png'),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}