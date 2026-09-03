import 'package:Discover/blocs/cart_bloc/cart_bloc.dart';
import 'package:Discover/models/cart_item_model.dart';
import 'package:Discover/models/product_model.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BottomActionPanel extends StatelessWidget {
  final ProductModel product;

  const BottomActionPanel({required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 24.w,
        vertical: 20.h,
      ).copyWith(bottom: MediaQuery.of(context).padding.bottom + 20.h),
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

          ElevatedButton.icon(
            onPressed: () async {
              final auth = FirebaseAuth.instance;
              context.read<CartBloc>().add(
                AddToCart(
                  userId: auth.currentUser?.uid ?? '',
                  cartItemModel: CartItemModel(product: product, quantity: 1),
                ),
              );
              await FirebaseAnalytics.instance.logViewCart(
                parameters: {
                  'product_id': product.id,
                  'product_name': product.title,
                  'price': product.price,
                },
              );

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
