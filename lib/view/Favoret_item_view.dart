import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Discover/blocs/favorite_bloc/favorite_bloc.dart';
import 'package:Discover/core/Widgets/product_ui.dart';

class FavoretItemsView extends StatelessWidget {
  const FavoretItemsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFCFCFC),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Favorite Items',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22.sp,
            color: const Color(0xff1A1A1A),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_none_outlined, color: Colors.black),
          ),
        ],
      ),
      body: BlocBuilder<FavoriteBloc, FavoriteState>(
        builder: (context, state) {
          if (state is FavoriteInitial) {
            return const Center(child: CircularProgressIndicator(color: Colors.black));
          } else if (state is FavoriteLoaded) {
            if (state.products.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.favorite_border_rounded, size: 70.sp, color: Colors.grey[300]),
                    SizedBox(height: 16.h),
                    Text(
                      'No Saved Items!',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'Add items you love to your favorites.',
                      style: TextStyle(color: Colors.grey, fontSize: 14.sp),
                    ),
                  ],
                ),
              );
            }
            return GridView.builder(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
              physics: const BouncingScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16.h,
                crossAxisSpacing: 16.w,
                childAspectRatio: 0.72,
              ),
              itemCount: state.products.length,
              itemBuilder: (context, index) {
                final product = state.products[index];
                return Product_Ui(
                  index: index,
                  path_image: product.thumbnail,
                  price: product.price.toString(),
                  title: product.title,
                  id: product.id,
                  product: product,
                );
              },
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}