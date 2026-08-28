part of 'category_bloc.dart';

enum CategoryStatus { initial, loading, loaded, error }

class CategoryState extends Equatable {
  final List<CategoryModel> categories;
  final CategoryStatus status;
  final String? selectedCategorySlug;
  final String? errorMessage;

  const CategoryState({
    this.categories = const [],
    this.status = CategoryStatus.initial,
    this.selectedCategorySlug,
    this.errorMessage,
  });

  CategoryState copyWith({
    List<CategoryModel>? categories,
    CategoryStatus? status,
    String? selectedCategorySlug,
    String? errorMessage,
  }) {
    return CategoryState(
      categories: categories ?? this.categories,
      status: status ?? this.status,
      selectedCategorySlug: selectedCategorySlug ?? this.selectedCategorySlug,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        categories,
        status,
        selectedCategorySlug,
        errorMessage,
      ];
}
