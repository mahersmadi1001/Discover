
import 'package:Discover/view/signup/signup_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NavToLogin extends StatelessWidget {
  const NavToLogin({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Don't have an account? ",
          style: TextStyle(
            color: const Color(0xff757575),
            fontSize: 15.sp,
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SignupView(),
              ),
            );
          },
          child: Text(
            "Sign Up",
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
