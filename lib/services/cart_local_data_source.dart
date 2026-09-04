import 'package:hive_flutter/hive_flutter.dart';
import 'package:Discover/models/cart_item_model.dart';

class CartLocalDataSource {
  final Map<String, Box> _boxes = {};

  Future<Box> _getBox(String userId) async {
    if (!_boxes.containsKey(userId) || !_boxes[userId]!.isOpen) {
      _boxes[userId] = await Hive.openBox("cart_$userId");
    }
    return _boxes[userId]!;
  }

  Future<void> saveProducts({
    required String userId,
    required List<CartItemModel> cartItems,
  }) async {
    try {
      final box = await _getBox(userId);
      List<Map<dynamic, dynamic>> cartItemMaps = List.generate(
        cartItems.length,
        (index) {
          return cartItems[index].toMap();
        },
      );
      await box.put("cart_list", cartItemMaps);
      print('Cart saved successfully for userId: $userId');
    } catch (e) {
      print('Error saving cart: $e');
      rethrow;
    }
  }

  Future<List<CartItemModel>> getProductsToShowInCart({
    required String userId,
  }) async {
    try {
      final box = await _getBox(userId);
      final data = await box.get("cart_list");

      print('Cart data retrieved for userId: $userId: $data');

      if (data != null) {
        final List<dynamic> list = data as List<dynamic>;

        List<CartItemModel> cartItems = list.map((item) {
          return CartItemModel.fromMap(Map<String, dynamic>.from(item as Map));
        }).toList();

        return cartItems;
      } else {
        return [];
      }
    } catch (e) {
      print('Error getting cart: $e');
      return [];
    }
  }

  Future<void> clearCart({required String userId}) async {
    try {
      final box = await _getBox(userId);
      await box.clear();
      print('Cart cleared for userId: $userId');
    } catch (e) {
      print('Error clearing cart: $e');
      rethrow;
    }
  }

  Future<void> addToCart({
    required String userId,
    required CartItemModel cartItem,
  }) async {
    try {
      List<CartItemModel> currentCart = await getProductsToShowInCart(
        userId: userId,
      );

     
      int existingIndex = currentCart.indexWhere(
        (item) => item.product.id == cartItem.product.id,
      );

      if (existingIndex != -1) {
  
        currentCart[existingIndex] = CartItemModel(
          product: currentCart[existingIndex].product,
          quantity: currentCart[existingIndex].quantity + cartItem.quantity,
        );
      } else {
   
        currentCart.add(cartItem);
      }

      await saveProducts(userId: userId, cartItems: currentCart);
      print('Item added to cart for userId: $userId');
    } catch (e) {
      print('Error adding to cart: $e');
      rethrow;
    }
  }

  Future<void> removeFromCart({
    required String userId,
    required String productId,
  }) async {
    try {
      List<CartItemModel> currentCart = await getProductsToShowInCart(
        userId: userId,
      );

      currentCart.removeWhere((item) => item.product.id == productId);

      await saveProducts(userId: userId, cartItems: currentCart);
      print('Item removed from cart for userId: $userId');
    } catch (e) {
      print('Error removing from cart: $e');
      rethrow;
    }
  }

  Future<void> updateQuantity({
    required String userId,
    required String productId,
    required int quantity,
  }) async {
    try {
      List<CartItemModel> currentCart = await getProductsToShowInCart(
        userId: userId,
      );

      int index = currentCart.indexWhere(
        (item) => item.product.id == productId,
      );

      if (index != -1) {
        if (quantity <= 0) {
          await removeFromCart(userId: userId, productId: productId);
        } else {
          currentCart[index] = CartItemModel(
            product: currentCart[index].product,
            quantity: quantity,
          );
          await saveProducts(userId: userId, cartItems: currentCart);
        }
        print('Quantity updated for userId: $userId');
      }
    } catch (e) {
      print('Error updating quantity: $e');
      rethrow;
    }
  }

  void dispose() {
    for (var box in _boxes.values) {
      box.close();
    }
    _boxes.clear();
  }
}
