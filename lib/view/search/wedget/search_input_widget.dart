import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchInputWidget extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  const SearchInputWidget({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: TextFormField(
        controller: controller,
        onChanged: onChanged,
        style: TextStyle(
          fontSize: 15.sp,
          fontWeight: FontWeight.w500,
          color: const Color(0xFF1E232C),
        ),
        cursorColor: const Color(0xFF1E232C),
        decoration: InputDecoration(
          filled: true,
          fillColor: const Color(0xFFF7F8F9),
          hintText: 'Search for products...',
          hintStyle: TextStyle(
            color: const Color(0xFF8391A1),
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
          ),
          prefixIcon: Icon(
            Icons.search_rounded,
            color: const Color(0xFF8391A1),
            size: 22.sp,
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: 18.w,
            vertical: 16.h,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: const BorderSide(
              color: Color(0xFFE8ECF4),
              width: 1.2,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: const BorderSide(
              color: Color(0xFF1E232C),
              width: 1.5,
            ),
          ),
        ),
      ),
    );
  }
}