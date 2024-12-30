import 'package:bloc/bloc.dart';
import 'package:bloc_clean_coding/repository/auth_api/auth_api_repository.dart';
import 'package:equatable/equatable.dart';
import '../../utils/enums.dart';
part 'invite_user_events.dart';
part 'invite_user_states.dart';
class InviteUserBloc extends Bloc<InviteUserEvent, InviteUserState> {
  AuthApiRepository authApiRepository;
  InviteUserBloc({required this.authApiRepository}) : super(const InviteUserState()) {
    on<InviteUserTime>(_onTimeChanged);
    on<InviteUserDate>(_onDateChanged);
    on<InviteUserRoomNo>(_onRoomNoChanged);
    on<InviteUserEmail>(_onEmailChanged);
    on<InviteUserApi>(_onFormSubmitted);
  }

  void _onTimeChanged(InviteUserTime event, Emitter<InviteUserState> emit) {
    emit(
      state.copyWith(
        time: event.time,
      ),
    );
  }

  void _onDateChanged(InviteUserDate event, Emitter<InviteUserState> emit) {
    emit(
      state.copyWith(
        date: event.date,
      ),
    );
  }

  void _onRoomNoChanged(InviteUserRoomNo event, Emitter<InviteUserState> emit) {
    emit(
      state.copyWith(
        roomNo: event.roomNo,
      ),
    );
  }

  void _onEmailChanged(InviteUserEmail event, Emitter<InviteUserState> emit) {
    emit(
      state.copyWith(
        email: event.email,
      ),
    );
  }

  Future<void> _onFormSubmitted(
    InviteUserApi event,
    Emitter<InviteUserState> emit,
  ) async {
    Map<String, String> data = {
      'email': state.email,
      'password': state.roomNo,
      'name': state.time,
      'fcm' : state.date
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

}
}  