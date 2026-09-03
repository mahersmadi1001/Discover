import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:Discover/models/Loginmodel.dart';
import 'package:Discover/models/signup_model.dart';
import 'package:Discover/services/di.dart';
import 'package:Discover/services/user_session_service.dart';

class AuthService {
  final FirebaseAuth _fireBaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final UserSessionService userSessionService = UserSessionService(
    sharedPreferences: getIt.get<SharedPreferences>(),
  );
  Future<bool> login({required LoginModel loginModel}) async {
    try {
      final UserCredential userCredential = await _fireBaseAuth
          .signInWithEmailAndPassword(
            email: loginModel.email,
            password: loginModel.password,
          );

      final user = _fireBaseAuth.currentUser;
      if (user != null) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('Login error: $e');
      return false;
    }
  }

  Future<bool> signup({required SignupModel signupModel}) async {
    try {
      final UserCredential userCredential = await _fireBaseAuth
          .createUserWithEmailAndPassword(
            email: signupModel.email,
            password: signupModel.password,
          );
      if (userCredential.user != null) {
        try {
          await userCredential.user!.updateDisplayName(signupModel.username);
        } catch (nameError) {
          print('Warning: Failed to update display name: $nameError');
        }

        return true;
      }

      return false;
    } on FirebaseException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      } else if (e.code == 'invalid-email') {
        print('The email address is not valid.');
      }
      return false;
    } catch (e) {
      print('Generic Signup error: $e');
      return false;
    }
  }

  Future<bool> signInWithGoogle() async {
    try {
      print('Google sign-in ');
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return false;

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await _fireBaseAuth.signInWithCredential(credential);

      final user = _fireBaseAuth.currentUser;
      if (user != null) {
        print('Google sign-in : true');
        return true;
      } else {
        print('Google sign-in : true');
        return false;
      }
    } catch (e) {
      print('Google sign-in error: $e');

      if (e.toString().contains('network') ||
          e.toString().contains('timeout')) {
        print('Network error: Please check your internet connection');
      }
      return false;
    }
  }

  Future<void> signout() async {
    try {
      await _googleSignIn.signOut();
      await _fireBaseAuth.signOut();
    } catch (e) {
      print('Signout error: $e');
    }
  }

  User? get currentUser => _fireBaseAuth.currentUser;
  Stream<User?> get authStateChanges => _fireBaseAuth.authStateChanges();
}
