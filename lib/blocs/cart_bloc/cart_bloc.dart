// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:Discover/models/cart_item_model.dart' show CartItemModel;
import 'package:Discover/services/cart_local_data_source.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartLocalDataSource cartLocalDataSource;
  List<CartItemModel> cartItems = [];
  CartBloc({required this.cartLocalDataSource}) : super(CartLoading()) {
    on<CartEvent>((event, emit) async {
      switch (event) {
        case InitiliazeCart():
          {
            cartItems = await cartLocalDataSource.getProductsToShowInCart(
              userId: event.userId,
            );
            if (cartItems.isEmpty) {
              emit(CartEmpty());
            } else {
              double total = 0;
              for (var item in cartItems) {
                total = total + (item.product.price * item.quantity);
              }
              emit(CartLoaded(cartItems: cartItems, totalPrice: total));
            }
          }
        case AddToCart():
          {
            print("===========================");
            int index = cartItems.indexWhere((element) {
              return element.product.id == event.cartItemModel.product.id;
            });
            if (index != -1) {
              cartItems[index].quantity++;
            } else {
              cartItems.add(event.cartItemModel);
            }
            cartLocalDataSource.saveProducts(
              userId: event.userId,
              cartItems: cartItems,
            );
            double total = 0;
            for (var item in cartItems) {
              total = total + (item.product.price * item.quantity);
            }
            emit(CartLoaded(cartItems: cartItems, totalPrice: total));
          }
        case RemoveFromCart():
          {
            int index = cartItems.indexWhere((element) {
              return element.product.id == event.cartItemModel.product.id;
            });
            if (index != -1) {
              if (cartItems[index].quantity > 1) {
                cartItems[index].quantity--;
              } else {
                cartItems.removeAt(index);
              }
              cartLocalDataSource.saveProducts(
                userId: event.userId,
                cartItems: cartItems,
              );
              double total = 0;
              for (var item in cartItems) {
                total = total + (item.product.price * item.quantity);
              }
              emit(CartLoaded(cartItems: cartItems, totalPrice: total));
            }
          }
      }
    });
  }
}
