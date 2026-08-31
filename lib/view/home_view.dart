import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Discover/blocs/category_bloc/category_bloc.dart';
import 'package:Discover/blocs/local_search_product_bloc/local_search_product_bloc.dart';
import 'package:Discover/blocs/product_bloc/product_bloc.dart';
import 'package:Discover/core/Widgets/category_chip_widget.dart';
import 'package:Discover/core/Widgets/product_ui.dart';
import 'package:Discover/view/search_view.dart';

final TextEditingController tff_controller = TextEditingController();

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - 200) {
        final categoryState = context.read<CategoryBloc>().state;
        if (categoryState.selectedCategorySlug == null ||
            categoryState.selectedCategorySlug == 'all') {
          context.read<ProductBloc>().add(GetAllProducts());
        }
      }
    });
    context.read<CategoryBloc>().add(LoadCategories());
    context.read<ProductBloc>().add(GetProductsByCategory(categorySlug: 'all'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Discover',
          style: TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: 22.sp,
            color: Colors.black,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.notifications_none_outlined,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 50.h,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF3F4F6),
                      borderRadius: BorderRadius.circular(15.r),
                    ),
                    child: TextField(
                      controller: tff_controller,
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        hintText: 'Search products...',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 14.sp,
                        ),
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Colors.grey,
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 12.h),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BlocProvider(
                          create: (context) =>
                              LocalSearchProductBloc()..add(GetAllData()),
                          child: SearchView(initialQuery: tff_controller.text),
                        ),
                      ),
                    );
                  },
                  child: Container(
                    width: 50.w,
                    height: 50.h,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(15.r),
                    ),
                    child: const Icon(
                      Icons.filter_list_rounded,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const CategoryChipWidget(),
          Expanded(
            child: BlocBuilder<ProductBloc, ProductState>(
              builder: (context, state) {
                if (state.productStatus == ProductStatus.initial &&
                    state.products.isEmpty) {
                  return const Center(
                    child: CircularProgressIndicator(color: Colors.black),
                  );
                }
                if (state.products.isEmpty &&
                    state.productStatus == ProductStatus.success) {
                  return const Center(child: Text("No Data Available"));
                }
                return GridView.builder(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 10.h,
                  ),
                  controller: scrollController,
                  physics: const BouncingScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 16.h,
                    crossAxisSpacing: 16.w,
                    childAspectRatio: 0.72,
                  ),
                  itemCount: state.hasReachedMax
                      ? state.products.length
                      : state.products.length + 1,
                  itemBuilder: (context, index) {
                    if (index >= state.products.length) {
                      return const Center(
                        child: CircularProgressIndicator(color: Colors.black),
                      );
                    }
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
              },
            ),
          ),
        ],
      ),
    );
  }
}
