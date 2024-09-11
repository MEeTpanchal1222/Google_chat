import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_chat/controler/auth_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../controler/chat_controller.dart';
import '../../controler/theme_controler.dart';
import '../../helper/Google_firebase_services.dart';
import '../../helper/user_services.dart';
import '../../modal/user_modal.dart';
import 'package:get/get.dart';

import '../auth/widgets/drawer_widget.dart';

class Home_screen extends StatelessWidget {
  const Home_screen({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeController themeController = Get.find();
    ChatController chatController = Get.put(ChatController());
    Auth_Controller auth_controller = Get.put(Auth_Controller());
    return Scaffold(
      drawer: CustomDrawer(authController: auth_controller),
      appBar:  AppBar(
        title: const Text("Google Chat",),
        actions: [
          Padding(
            padding: EdgeInsets.all(8.0).h,
            child: AnimatedIcon(icon: AnimatedIcons.ellipsis_search, progress:kAlwaysCompleteAnimation ),
          ),

         Padding(
              padding:  EdgeInsets.all(8.0).h,
              child: CircleAvatar(backgroundImage: NetworkImage("${GoogleFirebaseServices.googleFirebaseServices.auth.currentUser?.photoURL}"),),
            ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding:  EdgeInsets.all(16.0.h),
        child: Material(
          elevation: 10.0.h,
          color: Theme.of(context).colorScheme.inverseSurface,
          borderRadius: BorderRadius.circular(30.0.r),
          child: Container(
            height: 50.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildNavItem(Icons.home, 0,context),
                _buildNavItem(Icons.chat, 1,context),
                _buildNavItem(Icons.notifications, 2,context),
                _buildNavItem(Icons.settings, 3,context),
              ],
            ),
          ),
        ),
      ),

      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.all(8).h,
            child: FloatingActionButton(
              heroTag: 'Gemini',
              shape: CircleBorder(),
              onPressed:
                  () {
                       print("------------------------------------------");
                      print(GoogleFirebaseServices.googleFirebaseServices.auth.currentUser?.email);
                      Get.toNamed("/Aichat");

              },
              child: Image.asset('assets/icons/google-gemini-icon.png',height: 30,),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0).h,
            child:FloatingActionButton(
              heroTag: 'chat',
                  onPressed:
                      () {

                  },
                  child:  Icon(Icons.add_comment_rounded,color: Colors.blue.shade400,size: 35,),
                ),

          ),
        ],
      ),
      body:
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0).h,
            child: StreamBuilder(
              stream: UserService.userSarvice.getUser(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text(snapshot.error.toString(),style: TextStyle(color: Colors.black),),
                  );
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(color: Colors.black,),
                  );
                }

                var queryData = snapshot.data!.docs;
                print("----------------------------------------");
                print(snapshot.data!.docs);
                print("----------------------------------------");
                List users = queryData.map((e) => e.data()).toList();
                List<UserModal> userList = users.map((e) => UserModal(e)).toList();
                return ListView.builder(
                  itemCount: userList.length,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.all(8.0).h,
                    child: ListTile(
                        onTap: () {
                          chatController.changeReceiverEmail(userList[index].email!,userList[index].photoUrl!,userList[index].token!);
                          //print(userList[index].photoUrl!);
                          Get.toNamed('/chat');
                        },
                        leading: Hero(
                          tag: "user${index}",
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(
                              userList[index].photoUrl!,
                            ),
                          ),
                        ),
                        title: Text(userList[index].email!),
                      subtitle: Text(userList[index].phone!),
                    ),
                  ),
                );
              },
            ),
          ),
    );
  }
}

int _selectedIndex = 0;

void _onItemTapped(int index) {

    _selectedIndex = index;

}
Widget _buildNavItem(IconData icon, int index,BuildContext context) {
  return IconButton(
    icon: Icon(
      icon,
      color: _selectedIndex == index ? Theme.of(context).colorScheme.inversePrimary : Theme.of(context).colorScheme.tertiary,
      size: 25.h,
    ),
    onPressed: () => _onItemTapped(index),
  );
}
