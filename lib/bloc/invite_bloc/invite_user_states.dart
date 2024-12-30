part of 'invite_user_bloc.dart';

class InviteUserState extends Equatable {
  const InviteUserState({this.time = '', this.date = '', this.roomNo = '', this.email = '', this.postApiStatus = PostApiStatus.initial, this.message = ''});

  final String time;
  final String date;
  final String roomNo;
  final String email;
  final String message;
  final PostApiStatus postApiStatus;

  InviteUserState copyWith({String? time, String? date, String? roomNo, String? email, String? message, PostApiStatus? postApiStatus}) {
    return InviteUserState(time: time ?? this.time, date: date ?? this.date, roomNo: roomNo ?? this.roomNo, email: email ?? this.email, message: message ?? this.message, postApiStatus: postApiStatus ?? this.postApiStatus);
  }

  @override
  List<Object> get props => [time, date, roomNo, email, postApiStatus, message];
}