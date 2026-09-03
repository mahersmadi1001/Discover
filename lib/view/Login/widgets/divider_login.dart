
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DividerLogin extends StatelessWidget {
  const DividerLogin({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Divider(
            color: const Color(0xffE5E5E5),
            thickness: 1.sp,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: Text(
            "or continue with",
            style: TextStyle(
              color: const Color(0xff9E9E9E),
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Expanded(
          child: Divider(
            color: const Color(0xffE5E5E5),
            thickness: 1.sp,
          ),
        ),
      ],
    );
  }
}
