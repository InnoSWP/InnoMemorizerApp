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
    apiKey: 'AIzaSyCTdZF5MHPoLmnpNgol0oQzL7Ii8dVGxSQ',
    appId: '1:896956826040:web:cfa08b5b00ccd61ecb8f4d',
    messagingSenderId: '896956826040',
    projectId: 'innomemorize',
    authDomain: 'innomemorize.firebaseapp.com',
    storageBucket: 'innomemorize.appspot.com',
    measurementId: 'G-XKXSM9HLNL',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCpZ-4_zDusdNGPHX_AtJv3gsdVF2-zBbc',
    appId: '1:896956826040:android:ffc8102afd312933cb8f4d',
    messagingSenderId: '896956826040',
    projectId: 'innomemorize',
    storageBucket: 'innomemorize.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAgVt3o56DYtegKP1LbU3ntUxI7MPhWI_k',
    appId: '1:896956826040:ios:6caa912e5052929dcb8f4d',
    messagingSenderId: '896956826040',
    projectId: 'innomemorize',
    storageBucket: 'innomemorize.appspot.com',
    iosClientId: '896956826040-s26bq4ugua3rhviptdlbgbv0rgvn0in3.apps.googleusercontent.com',
    iosBundleId: 'com.example.memorizer',
  );
}
