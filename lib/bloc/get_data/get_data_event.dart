part of 'get_data_bloc.dart';

sealed class GetDataEvent extends Equatable {
  const GetDataEvent();

  @override
  List<Object> get props => [];
}

class FetchUser extends GetDataEvent {}

class FetchNewUser extends GetDataEvent {}
