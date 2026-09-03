
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ErrorSearchResult extends StatelessWidget {
  const ErrorSearchResult({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "An error occurred. Please try again.",
        style: TextStyle(
          color: const Color(0xFFE53935),
          fontSize: 15.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

class LoadingSearchResult extends StatelessWidget {
  const LoadingSearchResult({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: const Color(0xFF1E232C),
        strokeWidth: 3,
      ),
    );
  }
}