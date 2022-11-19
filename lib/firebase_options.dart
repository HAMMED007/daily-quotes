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
      apiKey: "AIzaSyCM3P1BJRyCdFnRRkt80kJGGUmm0h1YuRI",
      authDomain: "quote-generator-4f699.firebaseapp.com",
      projectId: "quote-generator-4f699",
      storageBucket: "quote-generator-4f699.appspot.com",
      messagingSenderId: "826156698717",
      appId: "1:826156698717:web:042defc16f121c6dd791b4");

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDMz-45h2DpbX-oJcNdCsKMcJlXnn3qaGI',
    appId: '1:826156698717:android:d76f262013d4d4bcd791b4',
    messagingSenderId: '826156698717',
    projectId: 'quote-generator-4f699',
    //storageBucket: 'antonx-flutter-template.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDMz-45h2DpbX-oJcNdCsKMcJlXnn3qaGI',
    appId: '1:826156698717:ios:4050a4e608893ff8d791b4',
    messagingSenderId: '826156698717',
    projectId: 'quote-generator-4f699',
    // storageBucket: 'antonx-flutter-template.appspot.com',
    // iosClientId:
    //     '816831984722-rnmhv8pt2rrq4b3tpi1i6o72rddqo074.apps.googleusercontent.com',
    iosBundleId: 'com.quoteGenerator',
  );
}
