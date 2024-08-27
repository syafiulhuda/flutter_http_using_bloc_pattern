import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_http_request/models/get_list_user.dart';
import 'package:http/http.dart' as http;

part 'get_list_data_event.dart';
part 'get_list_data_state.dart';

class GetListDataBloc extends Bloc<GetListDataEvent, GetListDataState> {
  // ! Set untuk menyimpan ID yang dihapus
  final Set<int> _deletedIds = {};

  GetListDataBloc() : super(GetListDataInitial()) {
    on<FetchListData>(_getListData);
  }

  void _getListData(FetchListData event, Emitter<GetListDataState> emit) async {
    emit(GetListDataLoading());

    Uri url =
        Uri.parse("https://reqres.in/api/users?page=${event.contentPerPage}");

    var response = await http.get(url);

    try {
      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);
        GetListUser getListUser = GetListUser.fromMap(data);

        // ! Filter data untuk menghilangkan ID yang sudah dihapus
        final filteredData = getListUser.data
            .where((user) => !_deletedIds.contains(user.id))
            .toList();

        emit(GetListDataLoaded(
            data: GetListUser(
          data: filteredData,
          totalPages: getListUser.totalPages,
          page: getListUser.page,
          support: getListUser.support,
        )));
      }
    } catch (e) {
      emit(GetListDataError(message: "Failed to load data: $e"));
    }
  }

  // ! Method untuk menghapus ID yang dihapus
  void markAsDeleted(int id) {
    _deletedIds.add(id);
  }

  // ! Method untuk menghapus semua ID yang dihapus
  void clearDeleteIds() {
    _deletedIds.clear();
  }
}
