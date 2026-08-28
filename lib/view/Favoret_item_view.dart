import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_packegs/blocs/favorite_bloc/favorite_bloc.dart';
import 'package:test_packegs/core/Widgets/product_ui.dart';

class FavoretItemsView extends StatelessWidget {
  const FavoretItemsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: context.read<FavoriteBloc>(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          title: Text(
            'Saved Items',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 26.sp,
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
        body: BlocBuilder<FavoriteBloc, FavoriteState>(
          builder: (context, state) {
            switch (state) {
              case FavoriteInitial():
                return Center(child: CircularProgressIndicator());

              case FavoriteLoaded():
                {
                  if (state.products.isEmpty) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.favorite_border_outlined,
                              size: 100.sp,
                              color: Color(0xffB3B3B3),
                            ),
                            Text(
                              'No Saved Items!',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 20.sp,
                              ),
                            ),
                            SizedBox(
                              width: 252.w,
                              child: Text(
                                'You don’t have any saved items. Go to home and add some.',
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
                  } else {
                    return Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          mainAxisSpacing: 20.h,
                          // crossAxisSpacing: .w,
                          crossAxisCount: 2,
                        ),
                        itemCount: state.products.length,
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
                      ),
                    );
                  }
                }
            }
          },
        ),
      ),
    );
  }
}
