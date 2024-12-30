part of 'invite_user_bloc.dart';

abstract class InviteUserEvent extends Equatable {
  const InviteUserEvent();

  @override
  List<Object> get props => [];
}

class InviteUserTime extends InviteUserEvent {
  const InviteUserTime({required this.time});

  final String time;

  @override
  List<Object> get props => [time];
}

class InviteUserDate extends InviteUserEvent {
  const InviteUserDate({required this.date});

  final String date;

  @override
  List<Object> get props => [date];
}

class InviteUserRoomNo extends InviteUserEvent {
  const InviteUserRoomNo({required this.roomNo});

  final String roomNo;

  @override
  List<Object> get props => [roomNo];
}

class InviteUserEmail extends InviteUserEvent {
  const InviteUserEmail({required this.email});

  final String email;

  @override
  List<Object> get props => [email];
}

class InviteUserApi extends InviteUserEvent {}