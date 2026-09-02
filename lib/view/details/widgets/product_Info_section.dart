
import 'package:Discover/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductInfoSection extends StatelessWidget {
  final ProductModel product;

  const ProductInfoSection({required this.product});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        
          Text(
            product.title,
            style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 26.sp,
              color: const Color(0xFF1A1A1A),
              height: 1.2,
            ),
          ),
          SizedBox(height: 12.h),

       
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF9E6),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.star_rounded,
                      color: const Color(0xFFFFB800),
                      size: 18.sp,
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      '4.0',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14.sp,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 12.w),
              Text(
                '(45 reviews)',
                style: TextStyle(
                  color: const Color(0xff808080),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          SizedBox(height: 24.h),

       
          Text(
            "Description",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18.sp,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 8.h),

  
          Text(
            product.description.toString(),
            style: TextStyle(
              color: const Color(0xFF666666),
              fontSize: 15.sp,
              height: 1.6, 
            ),
          ),
          SizedBox(height: 40.h), 
        ],
      ),
    );
  }
}

