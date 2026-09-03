import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Discover/blocs/local_search_product_bloc/local_search_product_bloc.dart';
import 'package:Discover/view/details/details_view.dart';

class SearchView extends StatefulWidget {
  final String initialQuery;
  
  const SearchView({
    super.key,
    required this.initialQuery,
  });

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController(text: widget.initialQuery);
    context.read<LocalSearchProductBloc>().add(
      SearchEvent(query: widget.initialQuery),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFF1E232C)),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SearchInputWidget(
            controller: _searchController,
            onChanged: (value) {
              context.read<LocalSearchProductBloc>().add(
                SearchEvent(query: value),
              );
            },
          ),
          SizedBox(height: 10.h),
          Expanded(
            child: BlocBuilder<LocalSearchProductBloc, LocalSearchProductState>(
              builder: (context, state) {
                if (state is LocalSuccess) {
                  return state.products.isEmpty
                      ? const EmptySearchResult()
                      : SearchResultsList(products: state.products);
                } else if (state is LocalError) {
                  return const ErrorSearchResult();
                }
                return const LoadingSearchResult();
              },
            ),
          ),
        ],
      ),
    );
  }
}

class SearchInputWidget extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  const SearchInputWidget({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: TextFormField(
        controller: controller,
        onChanged: onChanged,
        style: TextStyle(
          fontSize: 15.sp,
          fontWeight: FontWeight.w500,
          color: const Color(0xFF1E232C),
        ),
        cursorColor: const Color(0xFF1E232C),
        decoration: InputDecoration(
          filled: true,
          fillColor: const Color(0xFFF7F8F9),
          hintText: 'Search for products...',
          hintStyle: TextStyle(
            color: const Color(0xFF8391A1),
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
          ),
          prefixIcon: Icon(
            Icons.search_rounded,
            color: const Color(0xFF8391A1),
            size: 22.sp,
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: 18.w,
            vertical: 16.h,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: const BorderSide(
              color: Color(0xFFE8ECF4),
              width: 1.2,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: const BorderSide(
              color: Color(0xFF1E232C),
              width: 1.5,
            ),
          ),
        ),
      ),
    );
  }
}

class SearchResultsList extends StatelessWidget {
  final List products;

  const SearchResultsList({
    super.key,
    required this.products,
  });

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
        return SearchProductItem(
          product: products[index],
          index: index,
        );
      },
    );
  }
}

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

class EmptySearchResult extends StatelessWidget {
  const EmptySearchResult({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 100.h),
            Container(
              padding: EdgeInsets.all(24.w),
              decoration: BoxDecoration(
                color: const Color(0xFFF7F8F9),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.search_off_rounded,
                size: 60.sp,
                color: const Color(0xFF8391A1),
              ),
            ),
            SizedBox(height: 24.h),
            Text(
              'No Results Found',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.sp,
                color: const Color(0xFF1E232C),
              ),
            ),
            SizedBox(height: 12.h),
            SizedBox(
              width: 250.w,
              child: Text(
                'Try adjusting your search to find what you are looking for.',
                style: TextStyle(
                  color: const Color(0xFF8391A1),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ErrorSearchResult extends StatelessWidget {
  const ErrorSearchResult({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "An error occurred. Please try again.",
        style: TextStyle(
          color: const Color(0xFFE53935),
          fontSize: 15.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

class LoadingSearchResult extends StatelessWidget {
  const LoadingSearchResult({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: const Color(0xFF1E232C),
        strokeWidth: 3,
      ),
    );
  }
}