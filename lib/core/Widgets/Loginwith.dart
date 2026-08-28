import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Loginwith extends StatelessWidget {
  Loginwith({
    super.key,
    required this.path,
    this.color,
    required this.textcolor,
    required this.onPressed,
  });
  String path;
  Color? color;
  Color? textcolor;
  VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Color(0xffCCCCCC)),
        borderRadius: BorderRadius.all(Radius.circular(10.r)),
      ),
      minWidth: 341.w,
      onPressed: onPressed,
      height: 56.h,
      color: color,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(path, width: 24.w, height: 24.h),
          SizedBox(width: 9.w),
          Text(
            "Login with Google",
            style: TextStyle(fontSize: 16.sp, color: textcolor),
          ),
        ],
      ),
    );
  }
}
