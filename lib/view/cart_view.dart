import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:test_packegs/blocs/cart_bloc/cart_bloc.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          'My Cart',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 26,
            color: Color(0xff1A1A1A),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.notifications_none_outlined),
          ),
        ],
      ),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          switch (state) {
            case CartLoading():
              return Center(child: CircularProgressIndicator());
            case CartLoaded():
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.cartItems.length,
                      itemBuilder: (context, index) {
                        return Container(
                          width: 342.w,
                          height: 107.h,
                          margin: EdgeInsets.all(14.w),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Color.fromARGB(255, 208, 208, 208),
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(9.r),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                child: CachedNetworkImage(
                                  imageUrl:
                                      state.cartItems[index].product.thumbnail,
                                  height: 100.h,
                                  width: 120.w,
                                ),
                              ),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    state.cartItems[index].product.title,
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 15.h),
                                  Row(
                                    children: [
                                      Text(
                                        state.cartItems[index].product.price
                                            .toString(),
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(width: 100.w),
                                      SizedBox(
                                        width: 100.w,
                                        child: Expanded(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              IconButton(
                                                onPressed: () {
                                                  context.read<CartBloc>().add(
                                                    AddToCart(
                                                      cartItemModel: state
                                                          .cartItems[index],
                                                    ),
                                                  );
                                                },
                                                icon: Icon(Icons.add),
                                              ),
                                              Text(
                                                state.cartItems[index].quantity
                                                    .toString(),
                                                style: TextStyle(
                                                  fontSize: 30.sp,
                                                ),
                                              ),
                                              IconButton(
                                                onPressed: () {
                                                  context.read<CartBloc>().add(
                                                    RemoveFromCart(
                                                      cartItemModel: state
                                                          .cartItems[index],
                                                    ),
                                                  );
                                                },
                                                icon: Icon(Icons.remove),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),

                  Text(
                    "Total Price : ${state.totalPrice}",
                    style: TextStyle(fontSize: 30.sp),
                  ),
                  SizedBox(height: 18.h),
                  InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            backgroundColor: Colors.white,
                            content: Row(
                              children: [
                                Text(
                                  style: TextStyle(fontSize: 16.sp),
                                  "Totale Price : ${state.totalPrice.toString()}",
                                ),
                              ],
                            ),
                            title: Text(
                              "Are you shure ?",
                              style: TextStyle(color: Colors.grey),
                            ),
                            actions: [
                              MaterialButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(14.r),
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                color: Colors.grey,
                                child: Text(
                                  "No",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              MaterialButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(14.r),
                                  ),
                                ),
                                onPressed: () async {
                                  await Hive.deleteBoxFromDisk("shopping_cart");
                                  context.read<CartBloc>().add(
                                    InitiliazeCart(),
                                  );
                                  Navigator.pop(context);
                                },
                                color: Colors.black,
                                child: Text(
                                  "Yes",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: 345.w,
                      height: 55.h,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.all(Radius.circular(18.r)),
                      ),
                      child: Text(
                        "Go To Checkout",
                        style: TextStyle(color: Colors.white, fontSize: 22.sp),
                      ),
                    ),
                  ),
                  SizedBox(height: 100.h),
                ],
              );
            case CartEmpty():
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.shopping_cart,
                        size: 100.sp,
                        color: Color(0xffB3B3B3),
                      ),
                      Text(
                        'Your Cart is Empty!',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 20.sp,
                        ),
                      ),
                      SizedBox(
                        width: 248.w,
                        child: Text(
                          'When you add products, they’ll appear here.',
                          style: TextStyle(
                            color: Color(0xff808080),
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ],
              );
          }
        },
      ),
    );
  }
}
