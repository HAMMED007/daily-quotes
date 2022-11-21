import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import 'package:logger/logger.dart';

import '../../locator.dart';

import '../../ui/screens/auth_signup/sign_up/sign_up_screen.dart';
import '../models/body/login_body.dart';
import '../models/body/signup_body.dart';

import '../models/responses/auth_result.dart';
import '../others/logger_customizations/custom_logger.dart';
import 'database_service.dart';
import 'local_storage_service.dart';

///
/// [AuthService] class contains all authentication related logic with following
/// methods:
///
/// [doSetup]: This method contains all the initial authentication like checking
/// login status, onboarding status and other related initial app flow setup.
///
/// [signupWithEmailAndPassword]: This method is used for signup with email and password.
///
/// [signupWithApple]:
///
/// [signupWithGmail]:
///
/// [signupWithFacebook]:
///
/// [logout]:
///

class AuthService {
  late bool isLogin;
  final _localStorageService = locator<LocalStorageService>();
  final _dbService = locator<DatabaseService>();

  String? fcmToken;
  static final Logger log = CustomLogger(className: 'AuthService');
  final auth = FirebaseAuth.instance;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  User? user;

  ///
  /// [doSetup] Function does the following things:
  ///   1) Checks if the user is logged then:
  ///       a) Get the user profile data
  ///       b) Updates the user FCM Token
  ///
  doSetup() async {
    isLogin = _localStorageService.accessToken != null;
    if (isLogin) {
      log.d('>>>>>>>>>>>>>>>>>>>>>.User is already logged-in');
      //await _getUserProfile();
      await _dbService.getData();
    } else {
      log.d('@doSetup: User is not logged-in');
    }
  }

  Future<AuthResult> createUserWithEmailAndPassword(SignUpBody body) async {
    try {
      UserCredential credential = await auth.createUserWithEmailAndPassword(
          email: body.email!, password: body.password!);
      if (credential.user != null) {
        isLogin = true;
        user = credential.user;
        user!.getIdToken().then((value) {
          _localStorageService.accessToken = value;
        });
        await _dbService.getData();

        return AuthResult(status: true);
      } else {
        return AuthResult(status: false, error: 'Login failed');
      }
    } on FirebaseAuthException catch (e) {
      return AuthResult(status: false, error: e.message);
    }
  }

  Future<AuthResult> loginWithEmailAndPassword(LoginBody body) async {
    try {
      UserCredential credential = await auth.signInWithEmailAndPassword(
          email: body.email!, password: body.password!);
      if (credential.user != null) {
        isLogin = true;
        user = credential.user;
        if (user != null) {
          user!.getIdToken().then((value) {
            _localStorageService.accessToken = value;
          });
        }
        await _dbService.getData();
        return AuthResult(status: true);
      } else {
        return AuthResult(status: false, error: 'Login failed');
      }
    } on FirebaseAuthException catch (e) {
      return AuthResult(status: false, error: e.message);
    }
  }

  Future<AuthResult> sendPasswordResetEmail(String email) async {
    try {
      log.d('@forgot prassword password reset email:$email');
      await auth.sendPasswordResetEmail(email: email);

      return AuthResult(status: true);
    } on FirebaseAuthException catch (e) {
      return AuthResult(status: false, error: e.message);
    }
  }

  logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      isLogin = false;

      _localStorageService.accessToken = null;
      Get.offAll(() => SignUpScreen());
    } catch (e) {
      log.e('Exception @logout: $e');
    }
  }
}
