import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
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


  Future<void> createAccountUsingEmail(
      String email, String password, String name, String mobile,String image) async {

    print('------------------- Create function called--------------------------');


    try {
      print('------------------ Starting ---------------------------------');
      log("Sign Up Email : $email\n Password : $password");
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);


      print('------------------ Credential done ---------------------------------');

      User? user = userCredential.user;
      if (user != null) {
        // Add user data to Firestore
        await firestore.collection('users').doc(user.email).set({
          'email': email,
          'name': name,
          'mobile': mobile,
          'image': image,
        });

        print("User created and data added to Firestore: ${user.email}");
      }
    } catch (e) {
      log("ERROR : $e");
    }
  }
  Future<void> createEmailAndPassword(String? email, String? pwd) async {
    try {
      await auth.createUserWithEmailAndPassword(email: email!, password: pwd!);
      Get.toNamed('/signin');
    } catch (e) {
      log(e.toString());
    }
  }



  Future<void> compareEmailAndPwd(String? email, String? pwd) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email!, password: pwd!);
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

  void emailLogout() {
    try {
      googleSignIn.signOut();
      auth.signOut();
    } catch (e) {
      log(e.toString());
    }
  }

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

      auth.signInWithCredential(authCredential);
      currentUser();

      Map userModal = {
        'username': auth.currentUser!.displayName,
        'email': auth.currentUser!.email,
        'photoUrl':auth.currentUser!.photoURL,
      };

      UserModal user = UserModal(userModal);
      UserService.userSarvice.addUser(user);

      return "Suceess";
    } catch (e) {
      log(e.toString());
      return e.toString();
        //"Failed";
    }
  }

  User? currentUser() {
    User? user = auth.currentUser;
    if (user != null) {
      print(user.email);
      print(user.displayName);
      print(user.phoneNumber);
      print(user.photoURL);
    }
    return user;
  }

  Future<void> mobileUser(String number, String countryCode) async {
    try{
      await auth.verifyPhoneNumber(
        phoneNumber: countryCode + number,
        verificationCompleted: (PhoneAuthCredential credential) {
        },
        verificationFailed: (FirebaseAuthException e) {
          if (e.code == 'invalid-phone-number') {
            Fluttertoast.showToast(msg: 'The provided phone number is not valid.');
          }
        },
        codeSent: (String verificationId, int? resendToken) {
          sign.verificationId.value = verificationId;
          Get.toNamed('/otpAdd');
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    }catch(e)
    {
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