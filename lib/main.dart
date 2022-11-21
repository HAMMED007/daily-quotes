// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:on_call_protection/ui/screens/splash_screen.dart';
import 'app.dart';
import 'core/enums/env.dart';
import 'core/others/logger_customizations/custom_logger.dart';
import 'firebase_options.dart';
import 'locator.dart';

Future<void> main() async {
  final log = CustomLogger(className: 'main');
  try {
    log.i('Testing info logs');
    log.d('Testing debug logs');
    log.e('Testing error logs');
    log.wtf('Testing WTF logs');
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      name: 'Quote Generator',
      options: DefaultFirebaseOptions.currentPlatform,
    );
    // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    await setupLocator(Env.production);
    runApp(const MyApp(title: 'Quote Generator'));
  } catch (e) {
    log.e("$e");
  }
}
//project2