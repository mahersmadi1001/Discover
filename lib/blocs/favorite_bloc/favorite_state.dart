part of 'favorite_bloc.dart';

@immutable
sealed class FavoriteState {}

final class FavoriteInitial extends FavoriteState {}

class FavoriteLoaded extends FavoriteState {
  final List<ProductModel> products;

  FavoriteLoaded({required this.products});
}
