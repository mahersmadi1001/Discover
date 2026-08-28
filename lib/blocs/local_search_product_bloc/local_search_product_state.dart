part of 'local_search_product_bloc.dart';

@immutable
sealed class LocalSearchProductState {}

class LocalSearchProductInitial extends LocalSearchProductState {}

class LocalSuccess extends LocalSearchProductState {
  final List<ProductModel> products;

  LocalSuccess({required this.products});
}

class LocalError extends LocalSearchProductState {}

class LocalLoading extends LocalSearchProductState {}
