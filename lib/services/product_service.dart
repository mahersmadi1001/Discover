import 'package:dio/dio.dart';
import 'package:test_packegs/core/constants/api_constants.dart';
import 'package:test_packegs/models/category_model.dart';
import 'package:test_packegs/models/product_model.dart';

class ProductService {
  Future<List<ProductModel>?> getAllProducts({required int skip}) async {
    try {
      Response response = await Dio().get(
        "https://dummyjson.com/products?limit=${ApiConstants.limit}&skip=$skip",
      );
      print('Products response: ${response.statusCode}');
      if (response.statusCode == 200) {
        return List.generate(
          response.data["products"].length,
          (index) => ProductModel.fromMap(response.data["products"][index]),
        );
      } else {
        return null;
      }
    } catch (e) {
      print('Error loading products: $e');
      return null;
    }
  }

  Future<List<CategoryModel>?> getCategories() async {
    try {
      Response response = await Dio().get(
        "https://dummyjson.com/products/categories",
      );
      print('Categories response: ${response.statusCode}');
      print('Categories data: ${response.data}');
      if (response.statusCode == 200) {
        return List.generate(
          response.data.length,
          (index) => CategoryModel.fromMap(response.data[index]),
        );
      } else {
        return null;
      }
    } catch (e) {
      print('Error loading categories: $e');
      return null;
    }
  }

  Future<List<ProductModel>?> getProductsByCategory({
    required String category,
    required int skip,
  }) async {
    try {
      Response response = await Dio().get(
        "https://dummyjson.com/products/category/$category?limit=${ApiConstants.limit}&skip=$skip",
      );
      if (response.statusCode == 200) {
        return List.generate(
          response.data["products"].length,
          (index) => ProductModel.fromMap(response.data["products"][index]),
        );
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }
}
