import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'app.dart';
import 'core/enums/env.dart';
import 'firebase_options.dart';
import 'locator.dart';

Future<void> main() async {
  final log = Logger();
  try {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    await setupLocator(Env.test);
    runApp(const MyApp(title: 'Test - App Name'));
  } catch (e, s) {
    log.d("$e");
    log.d("$s");
  }
}
//project

// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   final log = Logger();
//   await Firebase.initializeApp();
//   log.d("Handling a background message: ${message.messageId}");
// }
