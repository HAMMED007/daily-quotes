import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:on_call_protection/core/constants/styles.dart';
import 'package:on_call_protection/ui/custom_widgets/custom_text_field.dart';
import 'package:provider/provider.dart';

import '../../../../core/enums/view_state.dart';
import '../../../../core/others/validation_class.dart';
import '../../../custom_widgets/custom_elevated_button.dart';
import '../../../custom_widgets/custom_linear_background.dart';
import '../forget_password/forget_password_screen.dart';

import 'sign_up_view_model.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}
//project
class _SignUpScreenState extends State<SignUpScreen>
    with SingleTickerProviderStateMixin {
  final formKeySignUp = GlobalKey<FormState>();
  final formKeyLognIn = GlobalKey<FormState>();

  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this, initialIndex: 0);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SignUpViewModel(),
      child: Consumer<SignUpViewModel>(
        builder: (context, model, child) => ModalProgressHUD(
          inAsyncCall: model.state == ViewState.busy,
          child: ChangeNotifierProvider(
            create: (context) => InputValidation(),
            child: Consumer<InputValidation>(
              builder: (context, model1, child) => Scaffold(
                body: SingleChildScrollView(
                  child: CustomLinearBackground(
                      child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 35.w),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                header(),
                                DefaultTabController(
                                  animationDuration: Duration(milliseconds: 0),
                                  length: 2,
                                  child: TabBar(
                                    indicatorColor: Colors.white,
                                    labelColor: Colors.white,
                                    unselectedLabelColor: Colors.white70,
                                    labelStyle: kTabBarText,
                                    controller: _tabController,
                                    tabs: [
                                      Tab(
                                        text: 'LogIn',
                                      ),
                                      Tab(
                                        text: 'SignUp',
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 30.h),
                                SizedBox(
                                  height: 1.sh - 300.h,
                                  child: TabBarView(
                                    controller: _tabController,
                                    children: [
                                      logIn(model, model1),
                                      //Signup form
                                      signUp(model, model1),
                                    ],
                                  ),
                                ),
                              ]))),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Form signUp(SignUpViewModel model, InputValidation model1) {
    return Form(
      key: formKeySignUp,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 40.h),
          CustomTextformField(
            hintText: 'Email',
            prefixIcon: Icon(
              Icons.email_outlined,
              color: Colors.black54,
              size: 25.h,
            ),
            onSaved: (email) {
              model.signUpBody.email = email.trim();
            },
            validate: model1.validateEmail,
          ),
          SizedBox(
            height: 30.h,
          ),
          CustomTextformField(
            hintText: 'Password',
            obscuredtext: model.signUpPasswordVisibility,
            prefixIcon: Icon(
              Icons.lock_outlined,
              color: Colors.black54,
              size: 25.h,
            ),
            suffixIcon: IconButton(
              icon: Icon(
                  model.signUpPasswordVisibility
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  color: Colors.black45),
              onPressed: model.signUpTogglePasswordVisibility,
            ),
            validate: model1.validatePassword,
            onChanged: (value) {
              model.signUpBody.password = value.trim();
            },
          ),
          SizedBox(
            height: 30.h,
          ),
          CustomTextformField(
            hintText: 'Confirm Password',
            obscuredtext: model.signUpPasswordVisibility,
            prefixIcon: Icon(
              Icons.lock_outlined,
              color: Colors.black54,
              // size: 25.r,
            ),
            suffixIcon: IconButton(
              icon: Icon(
                  model.signUpPasswordVisibility
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  color: Colors.black45),
              onPressed: model.signUpTogglePasswordVisibility,
            ),
            validate: model1.confirmedPasswordlValidation,
          ),
          SizedBox(
            height: 30.h,
          ),
          CustomElevatedButton(
              buttonchild: Text(
                'SignUp',
                style: kButtonText,
              ),
              onPressed: () {
                if (formKeySignUp.currentState!.validate()) {
                  formKeySignUp.currentState!.save();

                  model.createAccount();
                }
              }),
        ],
      ),
    );
  }

  Column header() {
    return Column(
      children: [
        SizedBox(
          height: 153.h,
        ),
        Text(
          'Welcome Back!',
          style: kWelcomeText,
        ),
        Text(
          'Secure your Authentication',
          style: kWelcomeDescriptionText,
        ),
        SizedBox(
          height: 60.h,
        ),
      ],
    );
  }

  Form logIn(SignUpViewModel model, InputValidation _inputValidation) {
    return Form(
      key: formKeyLognIn,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CustomTextformField(
            hintText: 'Email',
            prefixIcon: Icon(
              Icons.email_outlined,
              color: Colors.black54,
              size: 25.h,
            ),
            onSaved: (email) {
              model.loginBody.email = email.trim();
            },
            validate: _inputValidation.validateEmail,
          ),
          SizedBox(
            height: 30.h,
          ),
          CustomTextformField(
            onSaved: (password) {
              model.loginBody.password = password.trim();
            },
            hintText: 'Password',
            obscuredtext: model.loginPasswordVisibility,
            prefixIcon: Icon(
              Icons.lock_outlined,
              color: Colors.black54,
              size: 25.h,
            ),
            suffixIcon: IconButton(
              icon: Icon(
                  model.loginPasswordVisibility
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  color: Colors.black45),
              onPressed: model.loginTogglePasswordVisibility,
            ),
            validate: _inputValidation.validatePassword,
          ),
          SizedBox(
            height: 10.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                onTap: () {
                  Get.to(
                        () => ForgetPasswordScreen(),
                  );
                },
                child: Text(
                  'Forgot Password?',
                  style: kForgotPasswordText,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 40.h,
          ),
          CustomElevatedButton(
            buttonchild: Text(
              'Login',
              style: kButtonText,
            ),
            onPressed: () {
              if (formKeyLognIn.currentState!.validate()) {
                formKeyLognIn.currentState!.save();
                model.login();
              }
            },
          ),
        ],
      ),
    );
  }
}
