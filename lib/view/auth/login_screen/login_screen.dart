import 'package:flutter/material.dart';
import 'package:google_chat/main.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isAnimated = false;
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 500),(){
      setState(() {
        _isAnimated = true;
      });
    });

  }
  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return Scaffold(
        appBar:  AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Welcome  To  Google Chat",),),
      body: Stack(
        children: [
          AnimatedPositioned(
            top: mq.height*.15,
              right:_isAnimated? mq.width*.25: mq.width*.5,
              width: mq.width*.5,
              duration: Duration(seconds: 1 ),
              child: Image.asset('assets/Google_chat.png')),
          Positioned(
              bottom: mq.height*.18,
              left: mq.width*.09,
              width: mq.width*.8,
              height: mq.height*.07,
              child: ElevatedButton.icon(
                onPressed: () {
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
        ],
      ),
    );
  }
}
