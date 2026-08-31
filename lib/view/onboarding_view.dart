import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Discover/core/user_session/user_session_bloc.dart';

class OnboardingView extends StatelessWidget {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
            left: 24.w,
            top: 54.h,
            child: Text(
              "Define\n yourself in\n your unique\n way.",
              style: TextStyle(
                color: Color(0xff1A1A1A),
                fontSize: 45.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Positioned(
            top: 160,
            left: 0,
            child: SizedBox(
              width: 390.sp,
              child: Image.asset("images/imbording_shape.png"),
            ),
          ),
          Positioned(
            right: -25,
            bottom: 100,

            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Image.asset(
                  fit: BoxFit.cover,
                  "images/imbording.png",
                  width: 358.w,
                  height: 650.h,
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 21.h,
            right: 24.w,
            child: MaterialButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.sp)),
              ),
              onPressed: () {
                context.read<UserSessionBloc>().add(CompleteOnboarding());
              },
              color: Colors.black,
              minWidth: 341.w,
              height: 64.h,
              child: Row(
                children: [
                  Text("Get Started", style: TextStyle(color: Colors.white)),
                  SizedBox(width: 15.w),
                  Icon(Icons.arrow_forward, color: Colors.white),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
