import 'package:flutter/material.dart';
import 'package:google_chat/view/home_screen/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../view/auth/login_screen/login_screen.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // if our user is logged in
          if (snapshot.hasData) {
            return  Home_screen();
          } else {
            return LoginScreen();
          }
        },
      ),
    );
  }
}