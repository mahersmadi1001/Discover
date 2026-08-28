// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';

import 'package:meta/meta.dart';
import 'package:test_packegs/models/Loginmodel.dart';
import 'package:test_packegs/models/signup_model.dart';
import 'package:test_packegs/services/authservice.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthService authService;
  AuthBloc(this.authService) : super(AuthInitial()) {
    on<LoginEvent>((event, emit) async {
      emit(AuthLoading());
      bool isLogged = await authService.login(loginModel: event.loginModel);
      emit(
        isLogged
            ? AuthSuccess()
            : AuthError(
                errorMessage:
                    "failed to login, plesae check your information and try again...",
              ),
      );
    });

    on<SignupEvent>((event, emit) async {
      emit(AuthLoading());
      bool isSignedUp = await authService.signup(
        signupModel: event.signupModel,
      );
      emit(
        isSignedUp
            ? AuthSuccess()
            : AuthError(
                errorMessage:
                    "failed to signup, plesae check your information and try again...",
              ),
      );
    });

    on<GoogleSignInEvent>((event, emit) async {
      emit(AuthLoading());
      bool isSignedIn = await authService.signInWithGoogle();
      emit(
        isSignedIn
            ? AuthSuccess()
            : AuthError(
                errorMessage:
                    "failed to sign in with Google, please try again...",
              ),
      );
    });
  }
}
