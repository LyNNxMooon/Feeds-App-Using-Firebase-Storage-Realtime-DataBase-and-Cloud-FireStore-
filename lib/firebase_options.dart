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
        return macos;
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
    apiKey: 'AIzaSyDq7LeV-4zbJP-Jrx7oxBG-lR5kyGiIRQA',
    appId: '1:1022923178931:web:474227910a522e302481c6',
    messagingSenderId: '1022923178931',
    projectId: 'fire-base-demo-4c745',
    authDomain: 'fire-base-demo-4c745.firebaseapp.com',
    storageBucket: 'fire-base-demo-4c745.appspot.com',
    measurementId: 'G-28J7VFETQR',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDsfRtCkdVZD7lhLL92_Ip8gMKKGLYm57I',
    appId: '1:1022923178931:android:375ddd9b842de52b2481c6',
    messagingSenderId: '1022923178931',
    projectId: 'fire-base-demo-4c745',
    storageBucket: 'fire-base-demo-4c745.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAhvuaX_Rk6UXAkJDNQk3Qw-4OPmI0QHQ4',
    appId: '1:1022923178931:ios:51bd9cf3cb08cb362481c6',
    messagingSenderId: '1022923178931',
    projectId: 'fire-base-demo-4c745',
    storageBucket: 'fire-base-demo-4c745.appspot.com',
    iosBundleId: 'com.example.feeds',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAhvuaX_Rk6UXAkJDNQk3Qw-4OPmI0QHQ4',
    appId: '1:1022923178931:ios:2a433cb9eaa13fc12481c6',
    messagingSenderId: '1022923178931',
    projectId: 'fire-base-demo-4c745',
    storageBucket: 'fire-base-demo-4c745.appspot.com',
    iosBundleId: 'com.example.feeds.RunnerTests',
  );
}
