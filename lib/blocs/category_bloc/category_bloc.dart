import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:test_packegs/models/category_model.dart';
import 'package:test_packegs/services/product_service.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final ProductService productService;

  CategoryBloc({required this.productService}) : super(const CategoryState()) {
    on<LoadCategories>(_onLoadCategories);
    on<SelectCategory>(_onSelectCategory);
  }

  Future<void> _onLoadCategories(
    LoadCategories event,
    Emitter<CategoryState> emit,
  ) async {
    emit(state.copyWith(status: CategoryStatus.loading, errorMessage: null));
    
    final categories = await productService.getCategories();
    
    if (categories != null) {
      emit(state.copyWith(
        status: CategoryStatus.loaded,
        categories: categories,
      ));
    } else {
      emit(state.copyWith(
        status: CategoryStatus.error,
        errorMessage: 'Failed to load categories',
      ));
    }
  }

  Future<void> _onSelectCategory(
    SelectCategory event,
    Emitter<CategoryState> emit,
  ) async {
    emit(state.copyWith(selectedCategorySlug: event.categorySlug));
  }
}
