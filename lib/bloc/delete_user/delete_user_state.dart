part of 'delete_user_bloc.dart';

sealed class DeleteUserState extends Equatable {
  const DeleteUserState();

  @override
  List<Object> get props => [];
}

final class DeleteUserInitial extends DeleteUserState {}

final class DeleteUserLoading extends DeleteUserState {}

final class DeleteUserLoaded extends DeleteUserState {
  final int id;

  const DeleteUserLoaded({required this.id});

  @override
  List<Object> get props => [id];
}

final class DeleteUserError extends DeleteUserState {
  final String message;

  const DeleteUserError({required this.message});

  @override
  List<Object> get props => [message];
}
