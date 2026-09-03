import 'package:Discover/view/cart/widgets/cart_Item_card.dart';
import 'package:Discover/view/cart/widgets/cart_empty_state.dart';
import 'package:Discover/view/cart/widgets/checkout_section.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Discover/blocs/cart_bloc/cart_bloc.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    final user = _auth.currentUser;
    if (user != null) {
      context.read<CartBloc>().add(InitiliazeCart(userId: user.uid));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFCFCFC),
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        title: Text(
          'My Cart',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 20.sp,
            letterSpacing: 0.5,
            color: const Color(0xFF1A1A1A),
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 8.w),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.notifications_none_rounded,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state is CartLoading) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.black),
            );
          } else if (state is CartLoaded) {
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.only(top: 10.h, bottom: 20.h),
                    itemCount: state.cartItems.length,
                    itemBuilder: (context, index) {
                      final item = state.cartItems[index];
                      return TweenAnimationBuilder(
                        duration: Duration(milliseconds: 400 + (index * 100)),
                        tween: Tween<double>(begin: 0, end: 1),
                        builder: (context, double value, child) {
                          return Opacity(
                            opacity: value,
                            child: Transform.translate(
                              offset: Offset(0, 20 * (1 - value)),
                              child: child,
                            ),
                          );
                        },
                        child: CartItemCard(
                          item: item,
                          onAdd: () => context.read<CartBloc>().add(
                            AddToCart(
                              userId: _auth.currentUser?.uid ?? '',
                              cartItemModel: item,
                            ),
                          ),
                          onRemove: () => context.read<CartBloc>().add(
                            RemoveFromCart(
                              userId: _auth.currentUser?.uid ?? '',
                              cartItemModel: item,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                CheckoutSection(totalPrice: state.totalPrice.toString()),
              ],
            );
          } else if (state is CartEmpty) {
            return CartEmptyState();
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
