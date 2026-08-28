part of 'cart_bloc.dart';

@immutable
sealed class CartState {}

final class CartLoading extends CartState {}

class CartLoaded extends CartState {
  final List<CartItemModel> cartItems;
  final double totalPrice;

  CartLoaded({required this.cartItems, required this.totalPrice});
}

class CartEmpty extends CartState {}
