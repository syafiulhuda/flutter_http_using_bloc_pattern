part of 'get_list_data_bloc.dart';

sealed class GetListDataState extends Equatable {
  const GetListDataState();

  @override
  List<Object> get props => [];
}

final class GetListDataInitial extends GetListDataState {}

final class GetListDataLoading extends GetListDataState {}

final class GetListDataLoaded extends GetListDataState {
  final GetListUser data;

  const GetListDataLoaded({required this.data});

  @override
  List<Object> get props => [data];
}

final class GetListDataError extends GetListDataState {
  final String message;

  const GetListDataError({required this.message});

  @override
  List<Object> get props => [message];
}
