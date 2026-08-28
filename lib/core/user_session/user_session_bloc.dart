// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:test_packegs/services/user_session_service.dart';

part 'user_session_event.dart';
part 'user_session_state.dart';

class UserSessionBloc extends Bloc<UserSessionEvent, UserSessionState> {
  UserSessionService userSessionService;
  UserSessionBloc(this.userSessionService) : super(UserSessionInitial()) {
    on<UserSessionCheckStatus>((event, emit) async {
      print("UserSessionCheckStatus event ");
      await Future.delayed(Duration(seconds: 3));
      if (userSessionService.isFirstTimeOpen()) {
        emit(UserFirstTimeState());
        print("isFirstTimeOpen");
      } else {
        print("not isFirstTimeOpen");
        if (userSessionService.isAuthenticated()) {
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
      print("Event Fired: CompleteOnboarding");
    });

    on<Signout>((event, emit) {
      userSessionService.clearToken();
      emit(UserUnAuth());
    });
  }
}
