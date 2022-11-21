import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomElevatedButton extends StatelessWidget {
  CustomElevatedButton({
    required this.buttonchild,
    required this.onPressed,
    // this.padding,
    // required this.Padding,
  });

  final Widget buttonchild;
  final VoidCallback onPressed;
  // final EdgeInsetsGeometry? padding;
  //final EdgeInsetsGeometry Padding;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
          EdgeInsets.symmetric(
            vertical: 15.h,
          ),
        ),
        backgroundColor: MaterialStateProperty.all<Color>(Color(0xff4A5977)),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r),
          ),
        ),
      ),
      child: buttonchild,
      onPressed: onPressed,
    );
  }
}
//project