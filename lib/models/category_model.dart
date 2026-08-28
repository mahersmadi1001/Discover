import 'package:equatable/equatable.dart';

class CategoryModel extends Equatable {
  final String slug;
  final String name;
  final String url;

  CategoryModel({
    required this.slug,
    required this.name,
    required this.url,
  });

  CategoryModel copyWith({
    String? slug,
    String? name,
    String? url,
  }) {
    return CategoryModel(
      slug: slug ?? this.slug,
      name: name ?? this.name,
      url: url ?? this.url,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'slug': slug,
      'name': name,
      'url': url,
    };
  }

  factory CategoryModel.fromMap(Map<dynamic, dynamic> map) {
    return CategoryModel(
      slug: (map['slug'] ?? '') as String,
      name: (map['name'] ?? '') as String,
      url: (map['url'] ?? '') as String,
    );
  }

  @override
  List<Object?> get props => [slug, name, url];
}
