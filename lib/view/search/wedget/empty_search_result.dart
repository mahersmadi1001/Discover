import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmptySearchResult extends StatelessWidget {
  const EmptySearchResult({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 100.h),
            Container(
              padding: EdgeInsets.all(24.w),
              decoration: BoxDecoration(
                color: const Color(0xFFF7F8F9),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.search_off_rounded,
                size: 60.sp,
                color: const Color(0xFF8391A1),
              ),
            ),
            SizedBox(height: 24.h),
            Text(
              'No Results Found',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.sp,
                color: const Color(0xFF1E232C),
              ),
            ),
            SizedBox(height: 12.h),
            SizedBox(
              width: 250.w,
              child: Text(
                'Try adjusting your search to find what you are looking for.',
                style: TextStyle(
                  color: const Color(0xFF8391A1),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}