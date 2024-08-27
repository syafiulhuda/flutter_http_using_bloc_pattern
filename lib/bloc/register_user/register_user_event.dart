// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'register_user_bloc.dart';

sealed class RegisterUserEvent extends Equatable {
  const RegisterUserEvent();

  @override
  List<Object> get props => [];
}

class RegisterUser extends RegisterUserEvent {
  final RegisterNewUser registerNewUser;

  const RegisterUser({required this.registerNewUser});

  @override
  List<Object> get props => [registerNewUser];
}
