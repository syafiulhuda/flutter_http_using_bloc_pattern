part of 'update_data_bloc.dart';

sealed class UpdateDataState extends Equatable {
  const UpdateDataState();

  @override
  List<Object> get props => [];
}

final class UpdateDataInitial extends UpdateDataState {}

final class UpdateDataLoading extends UpdateDataState {}

final class UpdateDataLoaded extends UpdateDataState {
  final CreateNewUser data;

  const UpdateDataLoaded({required this.data});

  @override
  List<Object> get props => [data];
}

final class UpdateDataError extends UpdateDataState {
  final String message;

  const UpdateDataError({required this.message});

  @override
  List<Object> get props => [message];
}
