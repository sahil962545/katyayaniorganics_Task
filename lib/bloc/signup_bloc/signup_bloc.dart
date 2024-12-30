import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../repository/auth_api/auth_api_repository.dart';
import '../../services/storage/local_storage.dart';
import '../../utils/enums.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  AuthApiRepository authApiRepository;
  SignupBloc({required this.authApiRepository}) : super(const SignupState()) {
    on<NameChanged>(_onNameChanged);
    on<EmailChanged>(_onEmailChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<SigupApi>(_onFormSubmitted);
  }

  void _onEmailChanged(EmailChanged event, Emitter<SignupState> emit) {
    emit(
      state.copyWith(
        email: event.email,
      ),
    );
  }

  void _onPasswordChanged(PasswordChanged event, Emitter<SignupState> emit) {
    emit(
      state.copyWith(
        password: event.password,
      ),
    );
  }

  void _onNameChanged(NameChanged event, Emitter<SignupState> emit) {
    emit(
      state.copyWith(
        name: event.name,
      ),
    );
  }

  Future<void> _onFormSubmitted(
    SigupApi event,
    Emitter<SignupState> emit,
  ) async {
      final LocalStorage localStorage = LocalStorage();
     final fcmtoken = await localStorage.readValue('deviceToken');
    Map<String, String> data = {
      'email': state.email,
      'password': state.password,
      'name': state.name,
      'fcm' : fcmtoken.toString()
    };
    emit(state.copyWith(
      postApiStatus: PostApiStatus.loading,
    ));
    await authApiRepository.signupApi(data).then((value) async {
      emit(state.copyWith(postApiStatus: PostApiStatus.success));
    }).onError((error, stackTrace) {
      emit(state.copyWith(
          postApiStatus: PostApiStatus.error, message: error.toString()));
    });

    emit(state.copyWith(
      postApiStatus: PostApiStatus.loading,
    ));
    await authApiRepository.saveuserData(data).then((value) async {
      emit(state.copyWith(postApiStatus: PostApiStatus.success));
    }).onError((error, stackTrace) {
      emit(state.copyWith(
          postApiStatus: PostApiStatus.error, message: error.toString()));
    });
  }
}
