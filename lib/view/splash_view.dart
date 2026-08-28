import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff1A1A1A),
      body: SizedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 390.w,
              height: 580.h,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("images/splash_shape.png"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 270.h),
                  Image.asset("images/Vector.png", width: 134.w, height: 133.h),
                ],
              ),
            ),
            SizedBox(height: 150.h),
            CircularProgressIndicator(color: Colors.white, strokeWidth: 7),
          ],
        ),
      ),
    );
  }
}
