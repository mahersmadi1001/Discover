import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:Discover/services/authservice.dart';
import 'package:Discover/services/user_session_service.dart';
part 'user_session_event.dart';
part 'user_session_state.dart';

class UserSessionBloc extends Bloc<UserSessionEvent, UserSessionState> {
  UserSessionService userSessionService;
  AuthService authService = AuthService();
  final FirebaseAuth _fireBaseAuth = FirebaseAuth.instance;
  StreamSubscription<User?>? _authSubscription;


  UserSessionBloc(this.userSessionService) : super(UserSessionInitial()) {
   

    on<UserSessionCheckStatus>((event, emit) async {
      await Future.delayed(Duration(seconds: 3));
      if (userSessionService.isFirstTimeOpen()) {
        emit(UserFirstTimeState());
      } else {
        if (_fireBaseAuth.currentUser != null) {
          emit(UserAuthenticated());
        } else {
          emit(UserUnAuth());
        }
      }
    });

    on<LogingUser>((event, emit) async {
      emit(UserAuthenticated());
    });

    on<CompleteOnboarding>((event, emit) async {
      await userSessionService.completeOnboarding();
      emit(UserUnAuth());
    });

    on<Signout>((event, emit) async {
   

      await authService.signout();
      emit(UserUnAuth());

    });
  }

  @override
  Future<void> close() {
    _authSubscription?.cancel();
    return super.close();
  }
}
