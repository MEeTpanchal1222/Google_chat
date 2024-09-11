import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_chat/helper/Firebase_Messaging_services.dart';
import 'package:google_chat/view/auth/signup/sign_up_screen.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../controler/auth_controller.dart';
import '../modal/user_modal.dart';
import 'user_services.dart';

class GoogleFirebaseServices {
  Auth_Controller sign = Get.find();
  static GoogleFirebaseServices googleFirebaseServices =
      GoogleFirebaseServices._();

  GoogleFirebaseServices._();



  FirebaseAuth auth = FirebaseAuth.instance;
  GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;


  /// Signup

  Future<void> SignUpPage(
      {required String email,
      required String password,
      required String name,
      required String mobile,
      required String token}) async {
    try {
      log("Sign Up Email : $email\n Password : $password");
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);

      User? user = userCredential.user;
      userCredential.credential;
      Map userModal = {
        'username': user!.displayName,
        'email': user.email,
        'phone': user.phoneNumber,
        'photoUrl': user.photoURL,
        'token':token,
      };

      UserModal user1 = UserModal(userModal);
      UserService.userSarvice.addUser(user1);
      if (user != null) {
        // Add user data to Firestore
        await firestore.collection('user').doc(user.email).set({
          'email': email,
          'username': name,
          'phone': mobile,
          'photoUrl': user.photoURL,
          'token':token,
        });

        print("User created and data added to Firestore: ${user.email}");
        Get.toNamed("signin");
      }
    } catch (e) {
      log("ERROR : $e");
    }
  }





  // UPDATE USER TOKEN;
  Future<void> updateUserToken() async {
    String? token = await FirebaseMessagingServices.firebaseMessagingServices
        .generateDeviceToken();
    User? user = GoogleFirebaseServices.googleFirebaseServices.currentUser();
    firestore.collection('user').doc(user!.email).update({'token': token});
  }






  ///     check_email_exists

  Future<bool> checkEmailExists(String email) async {
    try {
      final signInMethods = await auth.fetchSignInMethodsForEmail(email);

      // Check if any sign-in methods exist for the email
      return signInMethods.isNotEmpty;
    } on FirebaseAuthException catch (e) {
      // Handle specific Firebase Auth exceptions
      if (e.code == 'invalid-email') {
        print('Invalid email format.');
      } else if (e.code == 'network-request-failed') {
        print('Network error. Please check your connection.');
      } else {
        print('An error occurred: ${e.message}');
      }
      return false;
    } catch (e) {
      // Handle any other errors
      print('Unexpected error: $e');
      return false;
    }
  }






  ///         Signin_page

  Future<void> Signin(String? email, String? pwd) async {
    checkEmailExists(email!);
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email!, password: pwd!);
      updateUserToken();
      Get.toNamed('/home');
    } on FirebaseAuthException catch (e) {
      log(e.code);
      if (e.code == 'user-not-found' || e.code == "invalid-email") {
        Fluttertoast.showToast(
            msg: "No User Found for that Email",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.redAccent,
            textColor: Colors.white,
            fontSize: 16.0);
      } else if (e.code == 'wrong-password' || e.code == 'invalid-credential') {
        Fluttertoast.showToast(
            msg: "Wrong Password Provided by User",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.redAccent,
            textColor: Colors.white,
            fontSize: 16.0);
      } else if (e.code == 'channel-error') {
        Fluttertoast.showToast(
            msg: "Enter the email and password",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.redAccent,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    }
  }








  //Logout

  void emailLogout() {
    try {
      googleSignIn.signOut();
      auth.signOut();
    } catch (e) {
      log(e.toString());
    }
  }








  /// Sign with  Google

  Future<String> signInWithGoogle() async {
      try {
        final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();
        GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount!.authentication;

        AuthCredential authCredential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken,
        );

    final UserCredential userCredential = await auth.signInWithCredential(authCredential);
    final User? user = userCredential.user;
        String? token = await FirebaseMessagingServices.firebaseMessagingServices.generateDeviceToken();
        Map userModal = {
          'username': user!.displayName,
          'email': user.email,
          'phone': user.phoneNumber,
          'photoUrl': user.photoURL,
          'token': token
        };
        print('\n \n   ${token} \n\n ');
        UserModal user1 = UserModal(userModal);
        UserService.userSarvice.addUser(user1);

        return "Suceess";
      } catch (e) {
        log(e.toString());
        return e.toString();
        //"Failed";
      }
  }





  /// to get current user

  User? currentUser() {
    User? user = auth.currentUser;
    if (user != null) {
      print(
          "========================================================================");
      print(
          "========================================================================");
      print(user.email);
      print(user.displayName);
      print(user.phoneNumber);
      print(user.photoURL);
      print(
          "========================================================================");
      print(
          "========================================================================");
    }
    return user;
  }









  Future<void> mobileUser(String number, String countryCode) async {
    try {
      await auth.verifyPhoneNumber(
        phoneNumber: countryCode + number,
        verificationCompleted: (PhoneAuthCredential credential) {},
        verificationFailed: (FirebaseAuthException e) {
          if (e.code == 'invalid-phone-number') {
            Fluttertoast.showToast(
                msg: 'The provided phone number is not valid.');
          }
        },
        codeSent: (String verificationId, int? resendToken) {
          sign.verificationId.value = verificationId;
          Get.toNamed('/otpAdd');
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } catch (e) {
      log(e.toString());
    }
    // mAuth.getFirebaseAuthSettings().setAppVerificationDisabledForTesting(true);
  }










  Future<void> mobileVarifaction(String smsCode) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: sign.verificationId.value, smsCode: smsCode);
      await auth.signInWithCredential(credential);
      Map userModal = {
        'username': auth.currentUser!.displayName,
        'email': sign.phone.value,
      };

      UserModal user = UserModal(userModal);
      UserService.userSarvice.addUser(user);
      Get.offAndToNamed('/home');
    } catch (e) {
      log(e.toString());
    }
  }
}
