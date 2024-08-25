part of 'update_data_bloc.dart';

sealed class UpdateDataEvent extends Equatable {
  const UpdateDataEvent();

  @override
  List<Object> get props => [];
}

class UpdateData extends UpdateDataEvent {
  final CreateNewUser user;

  const UpdateData({required this.user});

  @override
  List<Object> get props => [user];
}
