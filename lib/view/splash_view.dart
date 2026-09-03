import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0D0D0D),
      body: Stack(
        children: [
          SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                Center(
                      child: Container(
                        padding: EdgeInsets.all(28.r),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withOpacity(0.03),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.08),
                            width: 1.5.w,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.5),
                              blurRadius: 30,
                              spreadRadius: 5,
                            ),
                          ],
                        ),
                        child: Image.asset(
                          "images/Vector.png",
                          width: 110.w,
                          height: 110.h,
                        ),
                      ),
                    )
                    .animate()
                    .fadeIn(duration: 800.ms, delay: 200.ms)
                    .scale(
                      begin: const Offset(0.7, 0.7),
                      end: const Offset(1.0, 1.0),
                      curve: Curves.elasticOut,
                      duration: 1000.ms,
                    )
                    .shimmer(
                      delay: 1200.ms,
                      duration: 1800.ms,
                      color: Colors.white.withOpacity(0.4),
                    ),
                SizedBox(height: 24.h),
                Text(
                      "D I S C O V E R",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 6.0,
                      ),
                    )
                    .animate()
                    .fadeIn(duration: 800.ms, delay: 600.ms)
                    .slideY(begin: 0.3, end: 0, curve: Curves.easeOutQuad),
                const Spacer(),
                SizedBox(
                      width: 28.w,
                      height: 28.h,
                      child: const CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2.5,
                      ),
                    )
                    .animate()
                    .fadeIn(duration: 600.ms, delay: 900.ms)
                    .scale(
                      begin: const Offset(0.5, 0.5),
                      end: const Offset(1.0, 1.0),
                    ),
                SizedBox(height: 48.h),
              ],
            ),
          ),
        ],
      ),
    );
  }
}