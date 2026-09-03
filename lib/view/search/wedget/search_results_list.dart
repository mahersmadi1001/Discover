import 'package:Discover/view/search/wedget/search_product_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchResultsList extends StatelessWidget {
  final List products;

  const SearchResultsList({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      itemCount: products.length,
      separatorBuilder: (context, index) => Padding(
        padding: EdgeInsets.only(left: 70.w),
        child: Divider(
          height: 24.h,
          thickness: 1,
          color: const Color(0xFFF0F1F5),
        ),
      ),
      itemBuilder: (context, index) {
        return SearchProductItem(product: products[index], index: index);
      },
    );
  }
}
