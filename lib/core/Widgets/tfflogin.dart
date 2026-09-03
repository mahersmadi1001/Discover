import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final String hint;
  final bool obscureText;
  final TextEditingController? controller;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final void Function(String)? onChanged;

  const CustomTextField({
    super.key,
    required this.label,
    required this.hint,
    this.obscureText = false,
    this.controller,
    this.suffixIcon,
    this.prefixIcon,
    this.validator,
    this.keyboardType,
    this.textInputAction,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label علوي بأسلوب التصميم الحديث
        Text(
          label,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF1E232C),
          ),
        ),
        SizedBox(height: 8.h),
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          validator: validator,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          onChanged: onChanged,
          style: TextStyle(
            fontSize: 15.sp,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF1E232C),
          ),
          cursorColor: const Color(0xFF1E232C),
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xFFF7F8F9), // خلفية ناعمة تعطي مظهر فخم
            hintText: hint,
            hintStyle: TextStyle(
              color: const Color(0xFF8391A1),
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 18.w,
              vertical: 16.h,
            ),
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            
            // الحواف في الحالة العادية
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(
                color: Color(0xFFE8ECF4),
                width: 1.2,
              ),
            ),
            
            // الحواف عند التركيز (Focus)
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(
                color: Color(0xFF1E232C),
                width: 1.5,
              ),
            ),
            
            // الحواف في حالة وجود خطأ (Validation Error)
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(
                color: Color(0xFFE53935),
                width: 1.2,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(
                color: Color(0xFFE53935),
                width: 1.5,
              ),
            ),
            errorStyle: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }
}