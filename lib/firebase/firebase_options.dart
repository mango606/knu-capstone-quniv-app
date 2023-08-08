// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyB9sjFthF0Y0Oa041CUxoG_tpDKda0CsZs',
    appId: '1:421023492131:web:343a79adf84e5eb233e996',
    messagingSenderId: '421023492131',
    projectId: 'capstone-flutter-eb3c2',
    authDomain: 'capstone-flutter-eb3c2.firebaseapp.com',
    storageBucket: 'capstone-flutter-eb3c2.appspot.com',
    measurementId: 'G-6E27BX54FS',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDIR4rWlP2sPFJzyAFq08YFKAgzRP3cKjY',
    appId: '1:421023492131:android:9c3cf12d333d4ba133e996',
    messagingSenderId: '421023492131',
    projectId: 'capstone-flutter-eb3c2',
    storageBucket: 'capstone-flutter-eb3c2.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBIwjPCJsjW059m1-RhpBXDZysVO2kaZcM',
    appId: '1:421023492131:ios:9ef086f6c587d57033e996',
    messagingSenderId: '421023492131',
    projectId: 'capstone-flutter-eb3c2',
    storageBucket: 'capstone-flutter-eb3c2.appspot.com',
    iosClientId: '421023492131-nmjca5fti2rba4ut8dl3qcnemn8ruhsh.apps.googleusercontent.com',
    iosBundleId: 'com.example.capstone',
  );
}
