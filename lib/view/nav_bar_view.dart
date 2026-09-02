import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Discover/blocs/favorite_bloc/favorite_bloc.dart';
import 'package:Discover/blocs/product_bloc/product_bloc.dart';
import 'package:Discover/services/product_service.dart';
import 'package:Discover/view/Favoret_item_view.dart';
import 'package:Discover/view/account_view.dart';
import 'package:Discover/view/cart/cart_view.dart';
import 'package:Discover/view/home_view.dart';

class NavBarView extends StatefulWidget {
  const NavBarView({super.key});

  @override
  State<NavBarView> createState() => _NavBarViewState();
}

class _NavBarViewState extends State<NavBarView> {
  int currentPage = 0;
  final List<Widget> pages = [
    HomeView(),
    FavoretItemsView(),
    CartView(),
    AccountView(),
  ];
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              ProductBloc(productService: ProductService())
                ..add(GetAllProducts()),
        ),
        BlocProvider(
          create: (context) => FavoriteBloc()..add(InitializeFavoriteList()),
        ),
      ],

      child: Scaffold(
        backgroundColor: Colors.white,
        body: pages[currentPage],
        extendBody: true,
        bottomNavigationBar: Container(
          height: 90.h,
          decoration: BoxDecoration(color: Colors.transparent),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.r),
              topRight: Radius.circular(30.r),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.white.withOpacity(0.9),
                      Colors.white.withOpacity(0.6),
                    ],
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.r),
                    topRight: Radius.circular(30.r),
                  ),
                  border: Border(
                    top: BorderSide(
                      color: Colors.white.withOpacity(0.5),
                      width: 1.w,
                    ),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 20,
                      offset: Offset(0, -5),
                    ),
                  ],
                ),
                child: SafeArea(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 10.h,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildNavItem(
                          icon: Icons.home_outlined,
                          selectedIcon: Icons.home,
                          label: 'Home',
                          index: 0,
                        ),
                        _buildNavItem(
                          icon: Icons.favorite_outline,
                          selectedIcon: Icons.favorite,
                          label: 'Favorite',
                          index: 1,
                        ),
                        _buildNavItem(
                          icon: Icons.shopping_cart_outlined,
                          selectedIcon: Icons.shopping_cart,
                          label: 'Cart',
                          index: 2,
                        ),
                        _buildNavItem(
                          icon: Icons.person_outline,
                          selectedIcon: Icons.person,
                          label: 'Account',
                          index: 3,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required IconData selectedIcon,
    required String label,
    required int index,
  }) {
    final isSelected = currentPage == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          currentPage = index;
        });
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: isSelected
              ? Colors.black.withOpacity(0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isSelected ? selectedIcon : icon,
              color: isSelected ? Colors.black : Colors.grey,
              size: 24.sp,
            ),
            SizedBox(height: 4.h),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.black : Colors.grey,
                fontSize: 12.sp,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
