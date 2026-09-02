import 'package:Discover/view/details/widgets/bottom_action_panel.dart';
import 'package:Discover/view/details/widgets/product_Info_section.dart';
import 'package:Discover/view/details/widgets/product_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ProductImageHero(product: product, tag: index.toString()),
                  ProductInfoSection(product: product),
                ],
              ),
            ),
          ),

          BottomActionPanel(product: product),
        ],
      ),
    );
  }
}
