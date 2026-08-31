// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:Discover/blocs/cart_bloc/cart_bloc.dart';
import 'package:Discover/models/cart_item_model.dart';
import 'package:Discover/models/product_model.dart';

class DetailsView extends StatelessWidget {
  final ProductModel product;
  final int index;

  const DetailsView({super.key, required this.product, required this.index});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Details',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.sp),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 8.w),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.notifications_none_outlined,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // القسم القابل للتمرير (الصورة + التفاصيل)
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start, // المحاذاة لليسار
                children: [
                  _ProductImageHero(product: product, tag: index.toString()),
                  _ProductInfoSection(product: product),
                ],
              ),
            ),
          ),
          // الشريط السفلي الثابت (السعر + زر الإضافة للسلة)
          _BottomActionPanel(product: product),
        ],
      ),
    );
  }
}

class _ProductImageHero extends StatelessWidget {
  final ProductModel product;
  final String tag;

  const _ProductImageHero({required this.product, required this.tag});

  @override
  Widget build(BuildContext context) {
    return Hero(
      // ملاحظة: تأكد أن الـ tag هنا مطابق للـ tag في شاشة الرئيسية/المتجر
      tag: tag,
      child: Container(
        width: double.infinity,
        height: 380.h,
        margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: const Color(
            0xFFF8F9FA,
          ), // خلفية استوديو خفيفة جداً تبرز الصورة بدون خلفية
          borderRadius: BorderRadius.circular(24.r),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24.r),
          child: Padding(
            padding: EdgeInsets.all(20.w), // إبعاد الصورة عن الحواف
            child: CachedNetworkImage(
              imageUrl: product.thumbnail,
              fit: BoxFit
                  .contain, // استخدم contain للحفاظ على أبعاد الصور المفرغة
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

// ---------------------------------------------------------------------------
// 2. مكون تفاصيل المنتج (العنوان، التقييم، الوصف)
// ---------------------------------------------------------------------------
class _ProductInfoSection extends StatelessWidget {
  final ProductModel product;

  const _ProductInfoSection({required this.product});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // العنوان
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

          // التقييم والمراجعات
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
                      '4.0', // يفضل جلبها من الـ model
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

          // عنوان الوصف
          Text(
            "Description",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18.sp,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 8.h),

          // النص الوصفي
          Text(
            product.description.toString(),
            style: TextStyle(
              color: const Color(0xFF666666),
              fontSize: 15.sp,
              height: 1.6, // تباعد الأسطر لقراءة مريحة وفاخرة
            ),
          ),
          SizedBox(height: 40.h), // مساحة إضافية لتسهيل التمرير
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// 3. مكون الشريط السفلي (السعر وزر الإضافة) - Sticky Footer
// ---------------------------------------------------------------------------
class _BottomActionPanel extends StatelessWidget {
  final ProductModel product;

  const _BottomActionPanel({required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h).copyWith(
        bottom:
            MediaQuery.of(context).padding.bottom +
            20.h, // لدعم الشاشات ذات النوتش
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 20,
            offset: const Offset(0, -10),
          ),
        ],
        borderRadius: BorderRadius.vertical(top: Radius.circular(30.r)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // عرض السعر
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Total Price',
                style: TextStyle(
                  color: const Color(0xff808080),
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                "\$${product.price}",
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 24.sp,
                  color: Colors.black,
                ),
              ),
            ],
          ),

          // زر إضافة للسلة (Material 3 Button)
          ElevatedButton.icon(
            onPressed: () {
              context.read<CartBloc>().add(
                AddToCart(
                  cartItemModel: CartItemModel(product: product, quantity: 1),
                ),
              );

              // تفاعل بصري دقيق (Micro-interaction) عند الإضافة
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('Item added to cart successfully!'),
                  backgroundColor: Colors.black87,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  duration: const Duration(seconds: 2),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1A1A1A),
              foregroundColor: Colors.white,
              elevation: 0,
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.r),
              ),
            ),
            icon: Icon(Icons.shopping_bag_outlined, size: 20.sp),
            label: Text(
              'Add to Cart',
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}
