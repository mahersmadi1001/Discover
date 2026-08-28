
part of 'cart_bloc.dart';

@immutable
sealed class CartEvent {}

class InitiliazeCart extends CartEvent {}

class AddToCart extends CartEvent {
  final CartItemModel cartItemModel;

  AddToCart({required this.cartItemModel});
}

class RemoveFromCart extends CartEvent {
  final CartItemModel cartItemModel;
  RemoveFromCart({required this.cartItemModel});
}
