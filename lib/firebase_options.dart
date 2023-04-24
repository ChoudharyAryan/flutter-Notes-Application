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
    apiKey: 'AIzaSyBMSmuerThCWNqNlB_It3LAZLAx0qPuEXs',
    appId: '1:288625857388:web:ce764691845174980bd949',
    messagingSenderId: '288625857388',
    projectId: 'fluttersem2-91b4a',
    authDomain: 'fluttersem2-91b4a.firebaseapp.com',
    storageBucket: 'fluttersem2-91b4a.appspot.com',
    measurementId: 'G-YT6KJBXX59',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBefkpj4w_IfdjczRbB2DHbAij2TuPmNIc',
    appId: '1:288625857388:android:0c32731f759c33900bd949',
    messagingSenderId: '288625857388',
    projectId: 'fluttersem2-91b4a',
    storageBucket: 'fluttersem2-91b4a.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBeXmYZIUaR1gjz2P7c_0cBW6m_PCcrLqs',
    appId: '1:288625857388:ios:d39fbbf7039992730bd949',
    messagingSenderId: '288625857388',
    projectId: 'fluttersem2-91b4a',
    storageBucket: 'fluttersem2-91b4a.appspot.com',
    iosClientId: '288625857388-or11clogdorn9jjequk6t9lnkdnqo3hl.apps.googleusercontent.com',
    iosBundleId: 'com.example.flutterSem2',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBeXmYZIUaR1gjz2P7c_0cBW6m_PCcrLqs',
    appId: '1:288625857388:ios:d39fbbf7039992730bd949',
    messagingSenderId: '288625857388',
    projectId: 'fluttersem2-91b4a',
    storageBucket: 'fluttersem2-91b4a.appspot.com',
    iosClientId: '288625857388-or11clogdorn9jjequk6t9lnkdnqo3hl.apps.googleusercontent.com',
    iosBundleId: 'com.example.flutterSem2',
  );
}