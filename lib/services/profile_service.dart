import 'package:Discover/models/user_info_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ProfileService {
  final box = Hive.box("users");
  final boxid = Hive.box("user");
  Future getUserInfo({required String id}) async {
    try {
      UserInfoModel userinfo = box.get(id);
      return userinfo;
    } catch (e) {
      print("user info erorr $e");
    }
  }

  Future setUserInfo({required UserInfoModel user}) async {
    await box.add(user);
  
  }
}
