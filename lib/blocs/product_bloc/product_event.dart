part of 'product_bloc.dart';

sealed class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object?> get props => [];
}

final class GetAllProducts extends ProductEvent {}

final class GetProductsByCategory extends ProductEvent {
  final String? categorySlug;

  const GetProductsByCategory({this.categorySlug});

  @override
  List<Object?> get props => [categorySlug];
}
