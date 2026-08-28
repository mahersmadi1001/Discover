part of 'category_bloc.dart';

sealed class CategoryEvent extends Equatable {
  const CategoryEvent();

  @override
  List<Object?> get props => [];
}

final class LoadCategories extends CategoryEvent {}

final class SelectCategory extends CategoryEvent {
  final String? categorySlug;

  const SelectCategory({this.categorySlug});

  @override
  List<Object?> get props => [categorySlug];
}
