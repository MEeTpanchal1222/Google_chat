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
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.grey.shade600,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
        unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: "Chats",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group_work),
            label: "Channels",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_box),
            label: "Profile",
          ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FloatingActionButton(
              shape: CircleBorder(),
              onPressed:
                  () {

              },
              child: Image.asset('assets/icons/google-gemini-icon.png',height: 30,),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FloatingActionButton(
              onPressed:
              () {

              },
              child:  Icon(Icons.add_comment_rounded,color: Colors.blue.shade400,size: 35,),
            ),
          ),
        ],
      ),
    );
  }
}
