import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserSessionService {
  final String _firstTimeOpenKey = "first_time";
  final String _token = "token";
  final storage = const FlutterSecureStorage();
  SharedPreferences sharedPreferences;
  UserSessionService({required this.sharedPreferences});

  bool isFirstTimeOpen() {
    return sharedPreferences.getBool(_firstTimeOpenKey) ?? true;
  }

  bool isAuthenticated() {
    bool hasToken = !(storage.read(key: _token) == null);
    return hasToken;
  }

  Future<void> completeOnboarding() async { 
    await sharedPreferences.setBool(_firstTimeOpenKey, false);
  }
 
  Future<void> saveToken({required String? token}) async {
    await storage.write(key: _token, value: token!);
  }

  void clearToken() {
    storage.delete(key: _token);
  }
}
