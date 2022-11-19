import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/enums/view_state.dart';
import '../../../../core/others/base_view_model.dart';
import '../../../../core/services/auth_service.dart';
import '../../../../locator.dart';
import '../../../custom_widgets/dialogs/auth_dialog.dart';

class ForgetPasswordViewModel extends BaseViewModel {
  AuthService authService = locator<AuthService>();
  String? email;
  final formKey = GlobalKey<FormState>();

  forgotPasswordRequest() async {
    setState(ViewState.busy);
    final response = await authService.sendPasswordResetEmail(email!);
    if (response.status) {
      Get.snackbar(
          'Password Rest', 'Forgot password link has been sent to your email');
    } else {
      Get.dialog(AuthDialog(
          title: 'Forgot Password Request', message: '${response.error}'));
    }
    setState(ViewState.idle);
    // Get.back();
  }
}
