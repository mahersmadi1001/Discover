part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class LoginEvent extends AuthEvent {
  final LoginModel loginModel;

  LoginEvent({required this.loginModel});
}

class SignupEvent extends AuthEvent {
  final SignupModel signupModel;

  SignupEvent({required this.signupModel});
}

class GoogleSignInEvent extends AuthEvent {}
