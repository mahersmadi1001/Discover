import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_packegs/models/Loginmodel.dart';
import 'package:test_packegs/models/signup_model.dart';
import 'package:test_packegs/services/di.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<bool> login({required LoginModel loginModel}) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: loginModel.username,
        password: loginModel.password,
      );
      return true;
    } catch (e) {
      print('Login error: $e');
      return false;
    }
  }

  Future<bool> signup({required SignupModel signupModel}) async {
    try {
      await _auth.createUserWithEmailAndPassword( 
        email: signupModel.email,
        password: signupModel.password,
      );

      // Update user display name
      await _auth.currentUser?.updateDisplayName(signupModel.username);

      return true;
    } catch (e) {
      print('Signup error: $e');
      return false;
    }
  }

  Future<bool> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return false;

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await _auth.signInWithCredential(credential);
      return true;
    } catch (e) {
      print('Google sign-in error: $e');
      return false;
    }
  }

  Future<void> signout() async {
    try {
      await _googleSignIn.signOut();
      await _auth.signOut();
      await getIt.get<SharedPreferences>().clear();
    } catch (e) {
      print('Signout error: $e');
    }
  }

  User? get currentUser => _auth.currentUser;
  Stream<User?> get authStateChanges => _auth.authStateChanges();
}
