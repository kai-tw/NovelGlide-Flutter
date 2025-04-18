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
    apiKey: 'AIzaSyCIT4NMWlsemRpiWbOS_DlCcp3Acuw_lDY',
    appId: '1:569892023598:web:2762370b931a2d445b1ebf',
    messagingSenderId: '569892023598',
    projectId: 'novelglide',
    authDomain: 'novelglide.firebaseapp.com',
    storageBucket: 'novelglide.firebasestorage.app',
    measurementId: 'G-WNWCR8X82T',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBTNquFIAr2at8j6XRiNSDczSp_5nRxnfk',
    appId: '1:569892023598:android:3953d49865cefc345b1ebf',
    messagingSenderId: '569892023598',
    projectId: 'novelglide',
    storageBucket: 'novelglide.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAnhJ4bNpMOplz7PyrEiZKqFfbb9CTaAh8',
    appId: '1:569892023598:ios:e04daa603be98e525b1ebf',
    messagingSenderId: '569892023598',
    projectId: 'novelglide',
    storageBucket: 'novelglide.firebasestorage.app',
    androidClientId: '569892023598-5rnntoehoskm05rdev8obri1ufl52qgb.apps.googleusercontent.com',
    iosClientId: '569892023598-8n0gc07djd8f9no1n7a33e2c6bhiusjs.apps.googleusercontent.com',
    iosBundleId: 'com.kaiwu.novelglide',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAnhJ4bNpMOplz7PyrEiZKqFfbb9CTaAh8',
    appId: '1:569892023598:ios:e04daa603be98e525b1ebf',
    messagingSenderId: '569892023598',
    projectId: 'novelglide',
    storageBucket: 'novelglide.firebasestorage.app',
    androidClientId: '569892023598-5rnntoehoskm05rdev8obri1ufl52qgb.apps.googleusercontent.com',
    iosClientId: '569892023598-8n0gc07djd8f9no1n7a33e2c6bhiusjs.apps.googleusercontent.com',
    iosBundleId: 'com.kaiwu.novelglide',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyC95F4EtMgBl-BoveitRVcTtkGzqjdlNfw',
    appId: '1:569892023598:web:5a5cb08852945a2f5b1ebf',
    messagingSenderId: '569892023598',
    projectId: 'novelglide',
    authDomain: 'novelglide.firebaseapp.com',
    storageBucket: 'novelglide.firebasestorage.app',
    measurementId: 'G-V5QDVJ1TH2',
  );

}