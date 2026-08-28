import 'package:bloc/bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:meta/meta.dart';
import 'package:test_packegs/models/product_model.dart';

part 'favorite_event.dart';
part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  FavoriteBloc() : super(FavoriteInitial()) {
    on<FavoriteEvent>((event, emit) async {
      switch (event) {
        case InitializeFavoriteList():
          {
            final box = await Hive.openBox<ProductModel>('favorite_key');
            List<ProductModel> products = box.values.toList();
            for (var product in products) {
              print(product.id);
            }
            emit(FavoriteLoaded(products: products));
          }
        case ToggleFavorite():
          final box = await Hive.openBox<ProductModel>('favorite_key');
          List<ProductModel> products = box.values.toList();
          print(products);
          ProductModel? exsitingProduct;
          for (var product in products) {
            print("product exsit: ${product.id}");
            if (product.id == event.product.id) {
              exsitingProduct = product;
              break;
            }
          }
          if (exsitingProduct != null) {
            await exsitingProduct.delete();
          } else {
            await box.add(event.product);
          }
          emit(FavoriteLoaded(products: box.values.toList()));
      }
    });
  }
}
