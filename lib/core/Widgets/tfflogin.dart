import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TFFLogin extends StatelessWidget {
  TFFLogin({
    super.key,
    required this.hint,
    required this.controller,
    required this.lapel,
    required this.obscureText,
    this.iconscure,
  });
  String lapel;
  String hint;
  bool obscureText;
  Widget? iconscure;
  TextEditingController? controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        suffixIcon: iconscure,
        labelStyle: TextStyle(color: Colors.black, fontSize: 16.sp),
        hintStyle: TextStyle(color: Color(0xffE6E6E6), fontSize: 16.sp),
        // labelText: lapel,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xffE6E6E6), width: 1.w),
          borderRadius: BorderRadius.all(Radius.circular(10.r)),
        ),
        hintText: hint,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xffE6E6E6), width: 1.sp),
          borderRadius: BorderRadius.all(Radius.circular(10.r)),
        ),
      ),
    );
  }
}
