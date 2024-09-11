import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_chat/helper/Notification_services.dart';


class FirebaseMessagingServices {
  FirebaseMessagingServices._();

  static FirebaseMessagingServices firebaseMessagingServices =
  FirebaseMessagingServices._();

  String? token;
//
  Future<void> requestPermission()
  async {
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if(settings.authorizationStatus==AuthorizationStatus.authorized)
    {
      log('Notification Permission Allowed !');
    } else if(settings.authorizationStatus == AuthorizationStatus.denied)
    {
      log('Notification Permission Denied');
    }
  }




//
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  // 4. return token
  Future<String?> generateDeviceToken() async {
    token = await _firebaseMessaging.getToken();
    // todo user cloud store -save
    log("Device Token:$token}");
    return token;
  }





  //
  void onMessageListener()
  {
    FirebaseMessaging.onMessage.listen((event) {
      NotificationServices.notificationServices.showNotification(event.notification!.title!,event.notification!.body!);
    },);

  }
}