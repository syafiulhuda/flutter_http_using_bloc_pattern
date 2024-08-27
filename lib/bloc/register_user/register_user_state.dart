part of 'register_user_bloc.dart';

sealed class RegisterUserState extends Equatable {
  const RegisterUserState();

  @override
  List<Object> get props => [];
}

final class RegisterUserInitial extends RegisterUserState {}

final class RegisterUserLoading extends RegisterUserState {}

final class RegisterUserLoaded extends RegisterUserState {
  final RegisterNewUser registerUser;

  const RegisterUserLoaded({required this.registerUser});

  @override
  List<Object> get props => [registerUser];
}

final class RegisterUserError extends RegisterUserState {
  final String message;

  const RegisterUserError({required this.message});

  @override
  List<Object> get props => [message];
}
