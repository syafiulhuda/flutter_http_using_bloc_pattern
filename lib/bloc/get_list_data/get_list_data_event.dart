part of 'get_list_data_bloc.dart';

sealed class GetListDataEvent extends Equatable {
  const GetListDataEvent();

  @override
  List<Object> get props => [];
}

class FetchListData extends GetListDataEvent {
  final GetListUser? contentPerPage;

  const FetchListData({this.contentPerPage});

  @override
  List<Object> get props => [contentPerPage!];
}
