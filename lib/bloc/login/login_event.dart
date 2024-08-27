part of 'login_bloc.dart';

sealed class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginUser extends LoginEvent {
  final RegisterNewUser loginUser;

  const LoginUser({required this.loginUser});

  @override
  List<Object> get props => [loginUser];
}
