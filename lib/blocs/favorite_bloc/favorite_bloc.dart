import 'package:bloc/bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:meta/meta.dart';
import 'package:Discover/models/product_model.dart';

part 'favorite_event.dart';
part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  Box<ProductModel>? _box;
  String? _currentUserId;

  FavoriteBloc() : super(FavoriteInitial()) {
    on<FavoriteEvent>((event, emit) async {
      switch (event) {
        case InitializeFavoriteList():
          {
            if (_currentUserId != event.userId ||
                _box == null ||
                !_box!.isOpen) {
              _currentUserId = event.userId;
              _box = await Hive.openBox<ProductModel>(
                'favorites_${event.userId}',
              );
            }
            List<ProductModel> products = _box!.values.toList();
            for (var product in products) {
              print(product.id);
            }
            emit(FavoriteLoaded(products: products));
          }
        case ToggleFavorite():
          if (_currentUserId != event.userId || _box == null || !_box!.isOpen) {
            _currentUserId = event.userId;
            _box = await Hive.openBox<ProductModel>(
              'favorites_${event.userId}',
            );
          }
          List<ProductModel> products = _box!.values.toList();
          print(products);
          ProductModel? existingProduct;
          for (var product in products) {
            print("product exist: ${product.id}");
            if (product.id == event.product.id) {
              existingProduct = product;
              break;
            }
          }
          if (existingProduct != null) {
            await existingProduct.delete();
          } else {
            await _box!.add(event.product);
          }
          emit(FavoriteLoaded(products: _box!.values.toList()));
        case ClearFavorites():
          if (_currentUserId != event.userId || _box == null || !_box!.isOpen) {
            _currentUserId = event.userId;
            _box = await Hive.openBox<ProductModel>(
              'favorites_${event.userId}',
            );
          }
          await _box!.clear();
          emit(FavoriteLoaded(products: []));
      }
    });
  }

  @override
  Future<void> close() {
    _box?.close();
    return super.close();
  }
}
