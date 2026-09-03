part of 'cart_bloc.dart';

@immutable
sealed class CartEvent {}

class InitiliazeCart extends CartEvent {
  final String userId;

  InitiliazeCart({required this.userId});
}

class AddToCart extends CartEvent {
  final String userId;
  final CartItemModel cartItemModel;

  AddToCart({required this.userId, required this.cartItemModel});
}

class RemoveFromCart extends CartEvent {
  final String userId;
  final CartItemModel cartItemModel;
  RemoveFromCart({required this.userId, required this.cartItemModel});
}
