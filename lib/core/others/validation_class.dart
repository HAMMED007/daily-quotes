import 'package:flutter/material.dart';

import '../../locator.dart';
import '../models/body/reset_password_body.dart';
import '../models/body/signup_body.dart';

class InputValidation extends ChangeNotifier {
  final SignUpBody signUpBody = locator<SignUpBody>();
  final ResetPasswordBody updatePasswordBody = locator<ResetPasswordBody>();
  // name validation
  String? nameValidation(String? value) {
    return value == null
        ? 'Name is Mandatory'
        : value.length < 4
            ? "Name should be at least 4 char"
            : value.contains(RegExp(r'[0-9]'))
                ? "Name should not contain numbers"
                : null;
  }

  // email validation
  String? validateEmail(String? value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern);
    if (value!.isNotEmpty) {
      if (regex.hasMatch(value)) {
        return null;
      } else {
        return "Invalid email";
      }
    } else {
      return "Email is required";
    }
  }

  // password validation
  String? validatePassword(String? value) {
    return value != null && value.length < 8
        ? "Password should at least 8 char"
        : null;
  }

// confirmed password validation
  String? confirmedPasswordlValidation(String? value) {
    if (value != null && value.length < 8) {
      return "Password should at least 8 char";
    } else if (value == signUpBody.password) {
      return null;
    } else {
      return "Password does not match";
    }
  }

// confirmed password validation for reset password
  String? resetConfirmedPasswordlValidation(String? value) {
    if (value != null && value.length < 8) {
      return "Password should at least 8 char";
    } else if (value == updatePasswordBody.password) {
      return null;
    } else {
      return "Password does not match";
    }
  }

  String? validatePhoneNumber(String? value) {
    // create phone number pattern to validate phone number
    String pattern =
        r'(?=(?:[+ -]*[0-9][+ -]*){11,12}$)\+(?:[0-9]+[ -]?)+[0-9]$';
    RegExp regex = RegExp(pattern);
    if (value!.isNotEmpty) {
      if (regex.hasMatch(value)) {
        return null;
      } else {
        return "Valid i.e +923554433421";
      }
    } else {
      return "Phone number is required";
    }
  }
}
