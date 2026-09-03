import 'package:firebase_auth/firebase_auth.dart';
import 'package:Discover/models/user_info_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ProfileService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final String _usersBoxName = "users";

  Future<void> saveUserInfo({
    required String userId,
    required UserInfoModel userInfo,
  }) async {
    try {
      final box = await Hive.openBox<UserInfoModel>(_usersBoxName);
      await box.put(userId, userInfo);
      print('User info saved successfully for userId: $userId');
    } catch (e) {
      print('Error saving user info: $e');
      rethrow;
    }
  }

  Future<UserInfoModel?> getUserInfo({required String userId}) async {
    try {
      final box = await Hive.openBox<UserInfoModel>(_usersBoxName);
      final userInfo = box.get(userId);
      print('User info retrieved for userId: $userId');
      return userInfo;
    } catch (e) {
      print('Error getting user info: $e');
      return null;
    }
  }

  Future<void> updateUserInfo({
    required String userId,
    required Map<String, dynamic> updates,
  }) async {
    try {
      final box = await Hive.openBox<UserInfoModel>(_usersBoxName);
      final currentUserInfo = box.get(userId);
      if (currentUserInfo != null) {
        final updatedUserInfo = currentUserInfo.copyWith(
          name: updates['name'] as String?,
          phoneNumber: updates['phoneNumber'] as String?,
          address: updates['address'] as String?,
          profileImageUrl: updates['profileImageUrl'] as String?,
          cartCount: updates['cartCount'] as int?,
          favoritesCount: updates['favoritesCount'] as int?,
          lastLogin: updates['lastLogin'] as DateTime?,
        );
        await box.put(userId, updatedUserInfo);
        print('User info updated successfully for userId: $userId');
      }
    } catch (e) {
      print('Error updating user info: $e');
      rethrow;
    }
  }

  Future<void> deleteUserInfo({required String userId}) async {
    try {
      final box = await Hive.openBox<UserInfoModel>(_usersBoxName);
      await box.delete(userId);
      print('User info deleted for userId: $userId');
    } catch (e) {
      print('Error deleting user info: $e');
      rethrow;
    }
  }

  Future<UserInfoModel?> getCurrentUserInfo() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        return await getUserInfo(userId: user.uid);
      }
      return null;
    } catch (e) {
      print('Error getting current user info: $e');
      return null;
    }
  }

  Future<void> clearCurrentUserData() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        await clearUserCartAndFavorites(userId: user.uid);
        print('Current user data cleared for userId: ${user.uid}');
      }
    } catch (e) {
      print('Error clearing current user data: $e');
      rethrow;
    }
  }

  Future<void> clearUserCartAndFavorites({required String userId}) async {
    try {
      // Clear cart
      final cartBox = await Hive.openBox('cart_$userId');
      await cartBox.clear();
      print('Cart cleared for userId: $userId');

      // Clear favorites
      final favoritesBox = await Hive.openBox('favorites_$userId');
      await favoritesBox.clear();
      print('Favorites cleared for userId: $userId');
    } catch (e) {
      print('Error clearing user cart and favorites: $e');
      rethrow;
    }
  }
}
