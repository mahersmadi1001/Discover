import 'package:Discover/view/details/details_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchProductItem extends StatelessWidget {
  final dynamic product;
  final int index;

  const SearchProductItem({
    super.key,
    required this.product,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailsView(
              product: product,
              index: index,
            ),
          ),
        );
      },
      borderRadius: BorderRadius.circular(12.r),
      child: Row(
        children: [
          Container(
            width: 56.w,
            height: 56.w,
            decoration: BoxDecoration(
              color: const Color(0xFFF7F8F9),
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(
                color: const Color(0xFFE8ECF4),
                width: 1,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.r),
              child: CachedNetworkImage(
                imageUrl: product.thumbnail,
                fit: BoxFit.cover,
                placeholder: (context, url) => const Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Color(0xFFE8ECF4),
                  ),
                ),
                errorWidget: (context, url, error) => Icon(
                  Icons.image_not_supported_outlined,
                  color: const Color(0xFF8391A1),
                  size: 20.sp,
                ),
              ),
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Text(
              product.title,
              style: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF1E232C),
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Icon(
            Icons.arrow_forward_ios_rounded,
            color: const Color(0xFFD8DADC),
            size: 16.sp,
          ),
        ],
      ),
    );
  }
}