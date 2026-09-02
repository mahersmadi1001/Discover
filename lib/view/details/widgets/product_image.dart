
import 'package:Discover/models/product_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductImageHero extends StatelessWidget {
  final ProductModel product;
  final String tag;

  const ProductImageHero({required this.product, required this.tag});

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: tag,
      child: Container(
        width: double.infinity,
        height: 380.h,
        margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: const Color(
            0xFFF8F9FA,
          ), 
          borderRadius: BorderRadius.circular(24.r),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24.r),
          child: Padding(
            padding: EdgeInsets.all(20.w),
            child: CachedNetworkImage(
              imageUrl: product.thumbnail,
              fit: BoxFit
                  .contain,
              placeholder: (context, url) => const Center(
                child: CircularProgressIndicator(color: Colors.black),
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
        ),
      ),
    );
  }
}

