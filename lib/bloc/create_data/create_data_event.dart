part of 'create_data_bloc.dart';

sealed class CreateDataEvent extends Equatable {
  const CreateDataEvent();

  @override
  List<Object> get props => [];
}

class CreateUser extends CreateDataEvent {
  // ! Data user yang akan dibuat
  final CreateNewUser user;

  const CreateUser({required this.user});

  @override
  List<Object> get props => [user];
}
