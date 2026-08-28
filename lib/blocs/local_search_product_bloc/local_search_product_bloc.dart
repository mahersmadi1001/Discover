import 'package:bloc/bloc.dart';

import 'package:meta/meta.dart';
import 'package:test_packegs/models/product_model.dart';
import 'package:test_packegs/services/product_service.dart';

part 'local_search_product_event.dart';
part 'local_search_product_state.dart';

class LocalSearchProductBloc
    extends Bloc<LocalSearchProductEvent, LocalSearchProductState> {
  LocalSearchProductBloc() : super(LocalSearchProductInitial()) {
    List<ProductModel> allProducts = [];
    List<ProductModel> filteredProducts = [];
    on<GetAllData>((event, emit) async {
      emit(LocalLoading());
      List<ProductModel>? result = await ProductService().getAllProducts(
        skip: 0,
      );
      if (result != null) {
        allProducts = result;
        emit(LocalSuccess(products: allProducts));
      } else {
        emit(LocalError());
      }
    });
    on<SearchEvent>((event, emit) {
      if (event.query.isNotEmpty) {
        for (var i = 0; i < allProducts.length; i++) {
          if (allProducts[i].title.toLowerCase().contains(
            event.query.toLowerCase(),
          )) {
            filteredProducts.add(allProducts[i]);
          }
        }
        emit(LocalSuccess(products: filteredProducts));
      } else {
        emit(LocalSuccess(products: allProducts));
      }
    });
  }
}
