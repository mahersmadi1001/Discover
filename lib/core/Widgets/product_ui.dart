import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_packegs/blocs/favorite_bloc/favorite_bloc.dart';
import 'package:test_packegs/models/product_model.dart';
import 'package:test_packegs/view/details_view.dart';

class Product_Ui extends StatelessWidget {
  String path_image;
  int id;
  int index;
  ProductModel product;
  String title;
  String price;
  Product_Ui({
    Key? key,
    required this.path_image,
    required this.title,
    required this.index,
    required this.price,
    required this.id,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return DetailsView(product: product, index: index);
                },
              ),
            );
          },
          child: Container(
            width: 160.w,
            height: 260.h,
            decoration: BoxDecoration(
              border: Border.all(width: 1.w, color: Colors.black),
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Color(0xffE6E6E6),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15.r),
                        topRight: Radius.circular(15.r),
                      ),
                    ),
                    child: Hero(
                      tag: index,
                      child: CachedNetworkImage(
                        imageUrl: path_image,
                        width: 160.w,
                        height: 140.h,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Text(
                    overflow: TextOverflow.clip,
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14.sp,
                    ),
                    maxLines: 3,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Text('\$ ${price}', style: TextStyle(fontSize: 16.sp)),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          right: 25.w,
          top: 12.h,
          child: BlocBuilder<FavoriteBloc, FavoriteState>(
            builder: (context, state) {
              if (state is FavoriteLoaded) {
                bool isFav = state.products.any((item) {
                  return item.id == id;
                });
                return MaterialButton(
                  color: Colors.white,
                  minWidth: 35.w,
                  height: 35.h,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8.r)),
                  ),
                  onPressed: () {
                    context.read<FavoriteBloc>().add(
                      ToggleFavorite(product: product),
                    );
                  },
                  child: isFav
                      ? Icon(Icons.favorite, color: Colors.red, size: 24.sp)
                      : Icon(Icons.favorite_outline_outlined, size: 24.sp),
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ],
    );
  }
}
