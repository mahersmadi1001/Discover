import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserSessionService {
  final String _firstTimeOpenKey = "first_time";
  final FirebaseAuth _auth = FirebaseAuth.instance;
  SharedPreferences sharedPreferences;
  UserSessionService({required this.sharedPreferences});

  bool isFirstTimeOpen() {
    return sharedPreferences.getBool(_firstTimeOpenKey) ?? true;
  }

  bool isAuthenticated() {
    return _auth.currentUser != null;
  }

  Future<void> completeOnboarding() async {
    await sharedPreferences.setBool(_firstTimeOpenKey, false);
  }
  

  
}
