import 'dart:convert';
import 'package:hive/hive.dart';
part 'product_model.g.dart';

@HiveType(typeId: 0) // تأكد من الـ ID الخاص بك
class ProductModel extends HiveObject {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String? description;
  @HiveField(3)
  final String thumbnail;
  @HiveField(4)
  final num price;
  @HiveField(5)
  final String? category;

  ProductModel({
    required this.id,
    required this.title,
    this.description,
    required this.thumbnail,
    required this.price,
    this.category,
  });

  ProductModel copyWith({
    int? id,
    String? title,
    String? description,
    String? thumbnail,
    num? price,
    String? category,
  }) {
    return ProductModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      thumbnail: thumbnail ?? this.thumbnail,
      price: price ?? this.price,
      category: category ?? this.category,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'thumbnail': thumbnail,
      'price': price,
      'category': category,
    };
  }

  factory ProductModel.fromMap(Map<dynamic, dynamic> map) {
    return ProductModel(
      id: (map['id'] ?? 0) as int,
      title: (map['title'] ?? 'بدون عنوان') as String,
      description: map['description'] as String?,

      thumbnail: (map['thumbnail'] ?? '') as String,
      price: (map['price'] ?? 0.0) as num,
      category: map['category'] as String?,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) =>
      ProductModel.fromMap(json.decode(source) as Map<dynamic, dynamic>);
}
