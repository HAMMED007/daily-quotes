import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constants/styles.dart';

class CustomTextformField extends StatelessWidget {
  CustomTextformField({
    required this.validate,
    required this.prefixIcon,
    required this.hintText,
    this.suffixIcon,
    this.controller,
    this.onChanged,
    this.onSaved,
    this.obscuredtext = false,
  });

  final Function validate;
  final Widget prefixIcon;
  final String hintText;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final onChanged;
  final onSaved;
  final bool obscuredtext;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onChanged: onChanged,
      onSaved: onSaved,
      obscureText: obscuredtext,
      cursorColor: Colors.black54,
      style: kInputText,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 10.w),
        hintText: hintText,
        fillColor: Color.fromARGB(148, 255, 255, 255),
        filled: true,
        prefixIcon: prefixIcon,
        hintStyle: kInputText,
        errorStyle:
            TextStyle(fontSize: 14.sp, color: Color.fromARGB(255, 177, 12, 0)),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
        //error border
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(
            color: Color.fromARGB(255, 177, 12, 0),
          ),
        ),
        suffixIcon: suffixIcon,
      ),
      validator: (value) => validate(value),
    );
  }
}
