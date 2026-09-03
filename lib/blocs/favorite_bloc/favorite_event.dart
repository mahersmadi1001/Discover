part of 'favorite_bloc.dart';

@immutable
sealed class FavoriteEvent {}

class InitializeFavoriteList extends FavoriteEvent {
  final String userId;

  InitializeFavoriteList({required this.userId});
}

class ToggleFavorite extends FavoriteEvent {
  final String userId;
  final ProductModel product;

  ToggleFavorite({required this.userId, required this.product});
}

class ClearFavorites extends FavoriteEvent {
  final String userId;

  ClearFavorites({required this.userId});
}
