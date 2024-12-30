part of 'signup_bloc.dart';

class SignupState extends Equatable {
  const SignupState({this.email = '', this.password = '', this.postApiStatus = PostApiStatus.initial, this.message = '' , this.name = ''});

  final String email;
  final String password;
  final String message;
  final String name;
  final PostApiStatus postApiStatus;

  SignupState copyWith({String? email, String? password,String? name ,  String? message, PostApiStatus? postApiStatus}) {
    return SignupState(email: email ?? this.email, password: password ?? this.password,name: name ?? this.name, message: message ?? this.message, postApiStatus: postApiStatus ?? this.postApiStatus);
  }

  @override
  List<Object> get props => [email, password,name, postApiStatus, message];
}
