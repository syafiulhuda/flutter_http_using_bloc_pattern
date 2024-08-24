part of 'create_data_bloc.dart';

sealed class CreateDataState extends Equatable {
  const CreateDataState();

  @override
  List<Object> get props => [];
}

final class CreateDataInitial extends CreateDataState {}

final class CreateDataLoading extends CreateDataState {}

final class CreateDataLoaded extends CreateDataState {
  final CreateNewUser data;

  const CreateDataLoaded({required this.data});
}

final class CreateDataError extends CreateDataState {
  final String message;

  const CreateDataError({required this.message});
}
