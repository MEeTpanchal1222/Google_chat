// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDX236U9ak3HL8oy8Gt4-01fHBngAAdgf0',
    appId: '1:9476638440:web:5f2237c92d05d170036b5d',
    messagingSenderId: '9476638440',
    projectId: 'chat-d0a8a',
    authDomain: 'chat-d0a8a.firebaseapp.com',
    storageBucket: 'chat-d0a8a.appspot.com',
    measurementId: 'G-2ZS0L9MD5E',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAbqvVVEyFLdCHOwGod-UyY7JLWX6n4_FI',
    appId: '1:9476638440:android:4383a1859d276c53036b5d',
    messagingSenderId: '9476638440',
    projectId: 'chat-d0a8a',
    storageBucket: 'chat-d0a8a.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAPjQkY9K4nMNYJRLPT93-faYU1I801Z_0',
    appId: '1:9476638440:ios:efe84d640917e21a036b5d',
    messagingSenderId: '9476638440',
    projectId: 'chat-d0a8a',
    storageBucket: 'chat-d0a8a.appspot.com',
    iosBundleId: 'com.example.googleChat',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAPjQkY9K4nMNYJRLPT93-faYU1I801Z_0',
    appId: '1:9476638440:ios:efe84d640917e21a036b5d',
    messagingSenderId: '9476638440',
    projectId: 'chat-d0a8a',
    storageBucket: 'chat-d0a8a.appspot.com',
    iosBundleId: 'com.example.googleChat',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDX236U9ak3HL8oy8Gt4-01fHBngAAdgf0',
    appId: '1:9476638440:web:f9bd963dfc446dd7036b5d',
    messagingSenderId: '9476638440',
    projectId: 'chat-d0a8a',
    authDomain: 'chat-d0a8a.firebaseapp.com',
    storageBucket: 'chat-d0a8a.appspot.com',
    measurementId: 'G-JK5XS4KJQC',
  );
}
