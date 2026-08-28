// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'product_bloc.dart';

enum ProductStatus { initial, success, failure, loading }

class ProductState extends Equatable {
  List<ProductModel> products;
  ProductStatus productStatus;
  String? errorMessage;
  bool hasReachedMax;

  ProductState({
    this.products = const [],
    this.productStatus = ProductStatus.initial,
    this.hasReachedMax = false,
    this.errorMessage,
  });

  ProductState copyWith({
    List<ProductModel>? products,
    ProductStatus? productStatus,
    String? errorMessage,
    bool? hasReachedMax,
  }) {
    return ProductState(
      products: products ?? this.products,
      productStatus: productStatus ?? this.productStatus,
      errorMessage: errorMessage ?? this.errorMessage,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object?> get props => [
    products,
    productStatus,
    errorMessage,
    hasReachedMax,
  ];
}
