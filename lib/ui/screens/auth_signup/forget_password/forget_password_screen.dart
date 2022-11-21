import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:on_call_protection/core/constants/styles.dart';
import 'package:on_call_protection/core/others/validation_class.dart';
import 'package:on_call_protection/ui/custom_widgets/custom_elevated_button.dart';
import 'package:on_call_protection/ui/custom_widgets/custom_linear_background.dart';
import 'package:on_call_protection/ui/custom_widgets/custom_text_field.dart';
import 'package:provider/provider.dart';
import '../../../../core/enums/view_state.dart';
import 'forget_password_view_model.dart';

class ForgetPasswordScreen extends StatelessWidget {
  ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ForgetPasswordViewModel(),
      child: Consumer<ForgetPasswordViewModel>(
        builder: (context, model, child) => ModalProgressHUD(
          inAsyncCall: model.state == ViewState.busy,
          child: Scaffold(
              body: SingleChildScrollView(
                child: CustomLinearBackground(
                  width: 1.sw,
                  height: 1.sh,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 35.w),
                    child: Form(
                      key: model.formKey,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            SizedBox(
                              height: 70.h,
                            ),
                            Align(
                              alignment: Alignment.bottomLeft,
                              child: IconButton(
                                  onPressed: () => Get.back(),
                                  icon: Icon(
                                    Icons.arrow_back,
                                    color: Colors.white,
                                  )),
                            ),
                            SizedBox(
                              height: 70.h,
                            ),
                            Container(
                              child: SvgPicture.asset(
                                'assets/images/forget_password.svg',
                                fit: BoxFit.contain,
                              ),
                            ),
                            SizedBox(
                              height: 35.h,
                            ),
                            SizedBox(
                              width: 342.w,
                              child: Text(
                                'Please enter your registered email. A verification link will be sent to your registered email to reset password.',
                                style: kForgotDescriptionText,
                              ),
                            ),
                            SizedBox(
                              height: 30.h,
                            ),
                            CustomTextformField(
                              validate: InputValidation().validateEmail,
                              prefixIcon: Icon(
                                Icons.email_outlined,
                                color: Colors.black54,
                                //size: 25.r,
                              ),
                              hintText: 'Email',
                              onSaved: (value) {
                                model.email = value.trim();
                              },
                            ),
                            SizedBox(
                              height: 30.h,
                            ),
                            CustomElevatedButton(
                              // padding: EdgeInsets.symmetric(),
                              buttonchild: Text(
                                'Reset Password',
                                style: kButtonText,
                              ),
                              onPressed: () async {
                                if (model.formKey.currentState!.validate()) {
                                  model.formKey.currentState!.save();

                                  await model.forgotPasswordRequest();
                                }
                              },
                            ),
                          ]),
                    ),
                  ),
                ),
              )),
        ),
      ),
    );
    //project
  }
}
