import 'package:hive_flutter/hive_flutter.dart';
import 'package:test_packegs/models/cart_item_model.dart';

class CartLocalDataSource {
  Future<void> saveProducts({required List<CartItemModel> cartItems}) async {
    final box = await Hive.openBox("shopping_cart");
    List<Map<dynamic, dynamic>> cartItemMaps = List.generate(cartItems.length, (
      index,
    ) {
      return cartItems[index].toMap();
    });
    await box.put("cart_list", cartItemMaps);
  }

  Future<List<CartItemModel>> getProductsToShowInCart() async {
    final box = await Hive.openBox("shopping_cart");
    final data = await box.get("cart_list");

    print(data);

    if (data != null) {
      final List<dynamic> list = data as List<dynamic>;

      List<CartItemModel> cartItems = list.map((item) {
        return CartItemModel.fromMap(Map<String, dynamic>.from(item as Map));
      }).toList();

      return cartItems;
    } else {
      return [];
    }
  }
}
