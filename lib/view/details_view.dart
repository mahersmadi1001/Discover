// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:test_packegs/blocs/cart_bloc/cart_bloc.dart';
import 'package:test_packegs/models/cart_item_model.dart';
import 'package:test_packegs/models/product_model.dart';

class DetailsView extends StatelessWidget {
  ProductModel product;
  int index;
  DetailsView({super.key, required this.product, required this.index});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(centerTitle: true,
        backgroundColor: Colors.white,
        title: Text('Ditails', style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.notifications_none_outlined),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Hero(
            tag: index,
            child: ClipRRect(
              borderRadius: BorderRadiusGeometry.only(
                bottomRight: Radius.circular(24.r),
                bottomLeft: Radius.circular(24.r),
              ),
              child: CachedNetworkImage(
                imageUrl: product.thumbnail,
                width: 340.w,
                height: 360.h,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Text(
            product.title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.sp),
          ),
          SizedBox(height: 10.h),
          Row(
            children: [
              Icon(Icons.star, color: Colors.yellow),
              Row(
                children: [
                  Text('4.0/5'),
                  Text(
                    '(45 reviews)',
                    style: TextStyle(color: Color(0xff808080)),
                  ),
                ],
              ),
            ],
          ),
          Text(
            product.description.toString(),
            style: TextStyle(color: Color(0xff808080)),
          ),
          SizedBox(height: 10.h),
          Text(
            ' Size',
            style: TextStyle(
              color: Color(0xff1A1A1A),
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            children: [
              ChoseSize(size: 'S'),
              ChoseSize(size: 'M'),
              ChoseSize(size: 'L'),
            ],
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text('price'),
                    Text(
                      product.price.toString(),
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                InkWell(
                  onTap: () {
                    context.read<CartBloc>().add(
                      AddToCart(
                        cartItemModel: CartItemModel(
                          product: product,
                          quantity: 1,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    width: 240.w,
                    height: 40.h,
                    decoration: BoxDecoration(
                      color: Color(0xff1A1A1A),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.card_travel_sharp, color: Colors.white),
                        SizedBox(width: 10.w),
                        Text(
                          'Add to Cart',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ChoseSize extends StatelessWidget {
  String size;
  ChoseSize({Key? key, required this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        width: 50.w,
        height: 48.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Center(child: Text(size)),
      ),
    );
  }
}
