import 'package:flutter/material.dart';

class CustomLinearBackground extends StatelessWidget {
  CustomLinearBackground({required this.child, this.width, this.height});
  final Widget child;
  final width;
  final height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Color(0xFF000940),
            Color(0xFFCFD8DE),
          ],
        ),
      ),
      child: child,

      /// Column Contain app Bar And  User profile Image
    );
  }
}
