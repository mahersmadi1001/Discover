// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:test_packegs/models/product_model.dart';

class CartItemModel {
  final ProductModel product;
  int quantity;

  CartItemModel({
    required this.product,
    required this.quantity,
  });

  CartItemModel copyWith({
    ProductModel? product,
    int? quantity,
  }) {
    return CartItemModel(
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
    );
  }

  
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'product': product.toMap(),
      'quantity': quantity,
    };
  }

  factory CartItemModel.fromMap(Map<dynamic, dynamic> map) {
  return CartItemModel(
    product: ProductModel.fromMap(Map<dynamic, dynamic>.from(map['product'] as Map)),
    quantity: (map['quantity'] ?? 1) as int,
  );
}

  String toJson() => json.encode(toMap());

  factory CartItemModel.fromJson(String source) {
 
    final Map<String, dynamic> decodedData = 
        Map<String, dynamic>.from(json.decode(source) as Map);
    
    return CartItemModel.fromMap(decodedData);
  }

  @override
  String toString() => 'CartItemModel(product: $product, quantity: $quantity)';

  @override
  bool operator ==(covariant CartItemModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.product == product &&
      other.quantity == quantity;
  }

  @override
  int get hashCode => product.hashCode ^ quantity.hashCode;
}