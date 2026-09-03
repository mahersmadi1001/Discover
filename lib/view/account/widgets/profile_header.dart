
import 'package:Discover/models/user_info_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileHeader extends StatelessWidget {
  final UserInfoModel user;
  const ProfileHeader({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(7.sp),
          width: 70.w,
          height: 70.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: const Color(0xFFE8ECF4),
            border: Border.all(color: const Color(0xFFE8ECF4), width: 3),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.10),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Center(child: Image.asset("images/Vector.png")),
        ),
        SizedBox(width: 16.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              user.name ?? "",
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF1E232C),
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              user.email,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: const Color(0xFF8391A1),
              ),
            ),
          ],
        ),
      ],
    );
  }
}