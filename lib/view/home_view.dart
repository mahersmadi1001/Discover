import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_packegs/blocs/category_bloc/category_bloc.dart';
import 'package:test_packegs/blocs/local_search_product_bloc/local_search_product_bloc.dart';

import 'package:test_packegs/blocs/product_bloc/product_bloc.dart';
import 'package:test_packegs/core/Widgets/category_chip_widget.dart';
import 'package:test_packegs/core/Widgets/product_ui.dart';
import 'package:test_packegs/view/search_view.dart';

TextEditingController tff_controller = TextEditingController();

class HomeView extends StatefulWidget {
  HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
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

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        title: Text('Discover', style: TextStyle(fontWeight: FontWeight.bold)),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: SizedBox(
                  width: 260.w,
                  height: 50.h,
                  child: TextField(
                    cursorColor: Colors.grey,
                    controller: tff_controller,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.r),
                        borderSide: BorderSide(color: Colors.black, width: 2),
                      ),
                      filled: true,
                      fillColor: Color(0xffF9FAFB),
                      enabled: true,
                      hint: Row(
                        children: [
                          Icon(Icons.search, color: Color(0xff99A1AF)),
                          Text(
                            'Search Performs...',
                            style: TextStyle(color: Color(0xff99A1AF)),
                          ),
                        ],
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xff99A1AF)),
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                    ),
                  ),
                ),
              ),
              MaterialButton(
                minWidth: 50.w,
                height: 50.h,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(14.r)),
                ),
                color: Color(0xff1A1A1A),
                onPressed: () {
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
                child: Icon(Icons.filter_alt_outlined, color: Colors.white),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          const CategoryChipWidget(),
          Expanded(
            child: BlocBuilder<ProductBloc, ProductState>(
              builder: (context, state) {
                switch (state.productStatus) {
                  case ProductStatus.initial:
                    return Center(child: CircularProgressIndicator());
                  case ProductStatus.success:
                    {
                      if (state.products.isEmpty) {
                        return Center(child: Text("No Data"));
                      } else {
                        return GridView.builder(
                          padding: EdgeInsets.all(20.w),
                          controller: scrollController,

                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                mainAxisSpacing: 20.h,
                                crossAxisCount: 2,
                              ),
                          itemCount: state.hasReachedMax
                              ? state.products.length
                              : state.products.length + 1,
                          itemBuilder: (context, index) {
                            if (index >= state.products.length) {
                              return Center(child: CircularProgressIndicator());
                            } else {
                              return Product_Ui(
                                index: index,
                                path_image: state.products[index].thumbnail,
                                price: state.products[index].price.toString(),
                                title: state.products[index].title,
                                id: state.products[index].id,
                                product: state.products[index],
                              );
                            }
                          },
                        );
                      }
                    }
                  case ProductStatus.failure:
                    return Center(
                      child: Text(state.errorMessage ?? "Error Message"),
                    );
                  case ProductStatus.loading:
                    {
                      if (state.products.isEmpty) {
                        return Center(child: CircularProgressIndicator());
                      } else {
                        return GridView.builder(
                          controller: scrollController,
                          padding: EdgeInsets.all(20.w),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                mainAxisSpacing: 20.h,
                                crossAxisSpacing: 20.w,
                                crossAxisCount: 2,
                              ),
                          itemCount: state.hasReachedMax
                              ? state.products.length
                              : state.products.length + 1,
                          itemBuilder: (context, index) {
                            if (index >= state.products.length) {
                              return Center(child: CircularProgressIndicator());
                            } else {
                              return Product_Ui(
                                index: index,
                                path_image: state.products[index].thumbnail,
                                price: state.products[index].title,
                                title: state.products[index].title,
                                id: state.products[index].id,
                                product: state.products[index],
                              );
                            }
                          },
                        );
                      }
                    }
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
