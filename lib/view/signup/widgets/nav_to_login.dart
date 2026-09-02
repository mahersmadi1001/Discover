
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart' show SizeExtension;

class NavToLogin extends StatelessWidget {
  const NavToLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Already have an account? ",
          style: TextStyle(color: const Color(0xff757575), fontSize: 15.sp),
        ),
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Text(
            "Login",
            style: TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.w700,
              color: const Color(0xff111111),
            ),
          ),
        ),
      ],
    );
  }
}
