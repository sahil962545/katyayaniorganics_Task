import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../repository/auth_api/auth_api_repository.dart';
import '../../utils/enums.dart';
part 'login_events.dart';
part 'login_states.dart';

class LoginBloc extends Bloc<LoginEvents, LoginStates> {
  AuthApiRepository authApiRepository;
  LoginBloc({required this.authApiRepository}) : super(const LoginStates()) {
    on<EmailChanged>(_onEmailChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<LoginApi>(_onFormSubmitted);
  }

  void _onEmailChanged(EmailChanged event, Emitter<LoginStates> emit) {
    emit(
      state.copyWith(
        email: event.email,
      ),
    );
  }

  void _onPasswordChanged(PasswordChanged event, Emitter<LoginStates> emit) {
    emit(
      state.copyWith(
        password: event.password,
      ),
    );
  }

  Future<void> _onFormSubmitted(
    LoginApi event,
    Emitter<LoginStates> emit,
  ) async {
    Map<String, String> data = {
      'email': state.email,
      'password': state.password,
    };
    emit(state.copyWith(
      postApiStatus: PostApiStatus.loading,
    ));
    await authApiRepository.loginApi(data).then((value) async {
        emit(state.copyWith(postApiStatus: PostApiStatus.success));
    }).onError((error, stackTrace) {
      emit(state.copyWith(postApiStatus: PostApiStatus.error, message: error.toString()));
    });
  }
}
