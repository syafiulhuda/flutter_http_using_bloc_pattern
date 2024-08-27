part of 'delete_user_bloc.dart';

sealed class DeleteUserEvent extends Equatable {
  const DeleteUserEvent();

  @override
  List<Object> get props => [];
}

class DeleteUser extends DeleteUserEvent {
  final int id;

  const DeleteUser({required this.id});

  @override
  List<Object> get props => [id];
}
