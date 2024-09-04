import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_chat/helper/Google_firebase_services.dart';

import '../../../controler/auth_controller.dart';
import '../login_screen/login_screen.dart';

class CustomDrawer extends StatelessWidget {
  final Auth_Controller authController;

  CustomDrawer({
    super.key,
    required this.authController,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 245.h,
      child: Container(
        color: Theme.of(context).colorScheme.surface,
        child: Column(
          children: [
            Divider(
              color: Colors.grey.shade300,
              height: 1.h,
              thickness: 1.5.h,
            ),
           FutureBuilder<Map<String, dynamic>>(
                    future: authController.getUser(GoogleFirebaseServices.googleFirebaseServices.auth.currentUser!.email!),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const DrawerHeader(
                          child: Center(child: CircularProgressIndicator()),
                        );
                      } else if (snapshot.hasError) {
                        return const DrawerHeader(
                          child: Center(child: Text('Error loading user data')),
                        );
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const DrawerHeader(
                          child: Center(child: Text('No user data found')),
                        );
                      }

                      final userData = snapshot.data!;
                      final userName = userData['username'] ?? 'User name';
                      final userEmail = userData['email'] ?? 'No email';
                      final userPhoto = userData['photoUrl'] ??
                          'https://w7.pngwing.com/pngs/81/570/png-transparent-profile-logo-computer-icons-user-user-blue-heroes-logo-thumbnail.png';

                      return DrawerHeader(
                        //padding: EdgeInsets.all(10.h),
                        curve: Curves.bounceOut,
                        decoration: BoxDecoration(
                          color: Colors.blue.shade400,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(24.r),
                            bottomRight: Radius.circular(24.r),
                          ),
                        ),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 30.r,
                              backgroundImage: NetworkImage(userPhoto),
                              backgroundColor: Colors.white,
                            ),
                            SizedBox(width: 16.h),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  userName,
                                  style: TextStyle(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  userEmail,
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    color: Colors.white.withOpacity(0.7),
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
            _buildDrawerItem(
              context,
              icon: Icons.home,
              label: 'Home',
              onTap: () => Get.offNamed('/home'),
              color: Color(0xff3182c4),
            ),
            _buildDrawerItem(
              context,
              icon: Icons.chat,
              label: 'Chats',
              onTap: () => Get.offNamed('/chats'),
              color: Color(0xff3182c4),
            ),
            _buildDrawerItem(
              context,
              icon: Icons.settings,
              label: 'Settings',
              onTap: () => Get.toNamed('/settings'),
              color: Color(0xff3182c4),
            ),
            Padding(
              padding:  EdgeInsets.only(left: 25.h, bottom: 25.h),
              child: ListTile(
                title: Text(
                  'Logout',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                leading: Icon(
                  Icons.logout,
                  color: Colors.redAccent,
                  size: 26.r,
                ),
                onTap: () {
                  authController.emailLagout();
                  Fluttertoast.showToast(
                    msg: "Logged out successfully",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.black,
                    textColor: Colors.white,
                    fontSize: 16.sp,
                  );
                  Get.off(() => LoginScreen());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem(BuildContext context,
      {required IconData icon, required String label, required Function() onTap, required Color color}) {
    return ListTile(
      leading: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color.withOpacity(0.1),
        ),
        padding: EdgeInsets.all(6.r),
        child: Icon(
          icon,
          size: 24.r,
          color: color,
        ),
      ),
      title: Text(
        label,
        style: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
      onTap: onTap,
    );
  }
}
