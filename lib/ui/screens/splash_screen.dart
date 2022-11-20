import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:on_call_protection/core/constants/styles.dart';
import 'package:on_call_protection/ui/screens/auth_signup/sign_up/sign_up_screen.dart';
import 'package:on_call_protection/ui/screens/home_screens/home_screen.dart';
import '../../core/others/logger_customizations/custom_logger.dart';
import '../../core/services/auth_service.dart';
import '../../core/services/local_storage_service.dart';
import '../../locator.dart';
import '../custom_widgets/dialogs/network_error_dialog.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final _authService = locator<AuthService>();
  final _localStorageService = locator<LocalStorageService>();

  final Logger log = CustomLogger(className: 'Splash Screen');

  @override
  void didChangeDependencies() {
    _initialSetup();
    super.didChangeDependencies();
  }

  _initialSetup() async {
    await _localStorageService.init();

    ///
    /// If not connected to internet, show an alert dialog
    /// to activate the network connection.
    ///
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      Get.dialog(const NetworkErrorDialog());
      return;
    }

    await _authService.doSetup();
    await Future.delayed(Duration(seconds: 1));

    //
    ///checking if the user is login or not
    //
    log.d('@_initialSetup. Login State: ${_authService.isLogin}');
    if (_authService.isLogin) {
      Get.off(() => HomeScreen());
    } else {
      Get.off(() => SignUpScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    ///
    /// Splash Screen UI goes here.
    ///
    return Scaffold(
      body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF0D47A1),
                Color(0xFF42A5F5),
              ],
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 35.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SvgPicture.asset(
                      'assets/images/leftquote.svg',
                      // height: 300,
                      // width: 300,
                    ),
                  ],
                ),
                SizedBox(
                  height: 125.h,
                ),
                Text(
                  'Welcome To Quote\n      Generator',
                  style: kSplashScreenText,
                ),
                SizedBox(
                  height: 125.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SvgPicture.asset(
                      'assets/images/rightquote.svg',
                      // height: 300,
                      // width: 300,
                    ),
                  ],
                ),
              ],
            ),
          )),
    );
  }
}
