import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthServices{
  static AuthServices authServices = AuthServices._();

  AuthServices._();

  final FirebaseAuth auth = FirebaseAuth.instance;


 //to crate new account
  Future<String> crateAccount(String email, String password) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return "success";
    }
     catch (e) {
      log(e.toString());
      return e.toString();
    }
  }


  //to sign in
  Future<String> SignIn(String email,String password)
  async {
   try{
     await auth.signInWithEmailAndPassword(email: email, password: password);
     return "Successfully sign in !";
   }catch(e)
    {
      log(e.toString());
      return e.toString();
    }
  }



  //to signout
   Future<void> logout() async {
    await auth.signOut();
    User? user = auth.currentUser;
    if(user== null){
      Get.back();
    }
   }

}