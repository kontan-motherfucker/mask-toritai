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
    apiKey: 'AIzaSyC_-IZ_ZqOewjnbuMgErlAiGrlShwAHWes',
    appId: '1:812420741667:web:ed2e1c5cebdcc3cffbcf96',
    messagingSenderId: '812420741667',
    projectId: 'masktoritai-8594d',
    authDomain: 'masktoritai-8594d.firebaseapp.com',
    storageBucket: 'masktoritai-8594d.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBtqJltbvdQ9N61dMFQ59T5xHRhY7s4oTA',
    appId: '1:812420741667:android:fd6973138f0c4eebfbcf96',
    messagingSenderId: '812420741667',
    projectId: 'masktoritai-8594d',
    storageBucket: 'masktoritai-8594d.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA2o3YKWuPowuKx7fylnCAMeG8cfRPyPoc',
    appId: '1:812420741667:ios:f29e11a67420b623fbcf96',
    messagingSenderId: '812420741667',
    projectId: 'masktoritai-8594d',
    storageBucket: 'masktoritai-8594d.appspot.com',
    iosClientId: '812420741667-967s35h0n6vq0g4lrrn2ve4959es2ngq.apps.googleusercontent.com',
    iosBundleId: 'com.example.masktoritai',
  );
}