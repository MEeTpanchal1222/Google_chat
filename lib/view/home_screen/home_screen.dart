import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home_screen extends StatefulWidget {
  const Home_screen({super.key});

  @override
  State<Home_screen> createState() => _Home_screenState();
}

class _Home_screenState extends State<Home_screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        leading: Icon(Icons.person_rounded,size: 30,),
        title: const Text("Google Chat",),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: AnimatedIcon(icon: AnimatedIcons.ellipsis_search, progress:kAlwaysCompleteAnimation ),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: AnimatedIcon(icon: AnimatedIcons.home_menu, progress:kAlwaysCompleteAnimation ),
          ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FloatingActionButton(
              onPressed:
                  () {

              },
              child: Image.asset('assets/icons/google-gemini-icon.png',height: 40,),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FloatingActionButton(
              onPressed:
              () {

              },
              child:  Icon(Icons.add_comment_rounded,color: Colors.blue.shade400,),
            ),
          ),
        ],
      ),
    );
  }
}
