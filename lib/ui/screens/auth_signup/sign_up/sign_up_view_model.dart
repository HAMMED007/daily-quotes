import 'package:get/get.dart';
import 'package:logger/logger.dart';
import '../../../../core/enums/view_state.dart';
import '../../../../core/models/body/login_body.dart';
import '../../../../core/models/body/signup_body.dart';
import '../../../../core/models/responses/auth_response.dart';
import '../../../../core/others/base_view_model.dart';
import '../../../../core/services/auth_service.dart';
import '../../../../locator.dart';
import '../../home_screens/home_screen.dart';

class SignUpViewModel extends BaseViewModel {
  final AuthService authService = locator<AuthService>();
  LoginBody loginBody = LoginBody();
  final signUpBody = locator<SignUpBody>();
  late AuthResponse response;

  final log = Logger();
//

  createAccount() async {
    setState(ViewState.busy);
    print('@SignUpViewModel createAccount');

    final authResult =
        await authService.createUserWithEmailAndPassword(signUpBody);
    if (authResult.status) {
      Get.to(() => HomeScreen());
    } else {
      Get.snackbar('Login Failed', authResult.error!);
    }
    setState(ViewState.idle);
  }

  void login() async {
    setState(ViewState.busy);
    final authResult = await authService.loginWithEmailAndPassword(loginBody);
    if (authResult.status) {
      Get.to(() => HomeScreen());
      //snackbar

    } else {
      Get.snackbar('Login Failed', authResult.error!);
    }
    setState(ViewState.idle);
  }

//
  bool loginPasswordVisibility = true;
  loginTogglePasswordVisibility() {
    setState(ViewState.busy);
    loginPasswordVisibility = !loginPasswordVisibility;
    setState(ViewState.idle);
  }

  bool signUpPasswordVisibility = true;
  signUpTogglePasswordVisibility() {
    setState(ViewState.busy);
    signUpPasswordVisibility = !signUpPasswordVisibility;
    setState(ViewState.idle);
  }
}
