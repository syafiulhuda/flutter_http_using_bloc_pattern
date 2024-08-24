part of 'get_data_bloc.dart';

sealed class GetDataState extends Equatable {
  const GetDataState();

  @override
  List<Object> get props => [];
}

final class GetDataInitial extends GetDataState {}

final class GetDataLoading extends GetDataState {}

final class GetDataLoaded extends GetDataState {
  final GetSingleUser user;

  const GetDataLoaded({required this.user});

  @override
  List<Object> get props => [user];
}

final class GetDataError extends GetDataState {
  final String message;

  const GetDataError({required this.message});

  @override
  List<Object> get props => [message];
}
