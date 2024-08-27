import 'dart:convert';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_http_request/models/get_single_user.dart';
import 'package:http/http.dart' as http;

part 'get_data_event.dart';
part 'get_data_state.dart';

class GetDataBloc extends Bloc<GetDataEvent, GetDataState> {
  final Set<int> deletedIds =
      {}; // Definisikan set untuk menyimpan ID yang dihapus

  GetDataBloc() : super(GetDataInitial()) {
    // !
    // ? Use the code
    on<FetchUser>(_onFetchDataViaHttp);
    on<FetchNewUser>(_onFetchDataNewID);
  }

  // !
  // ? Init data
  void _onFetchDataViaHttp(FetchUser event, Emitter<GetDataState> emit) async {
    emit(GetDataLoading());

    // !
    // ? set up HTTP Method
    try {
      // int randomId = Random().nextInt(12) + 1;
      Uri url = Uri.parse("https://reqres.in/api/users/2");

      var response = await http.get(url);

      // !
      // ? Handle response
      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);

        GetSingleUser user = GetSingleUser.fromMap(data);

        emit(GetDataLoaded(user: user));
      } else {
        emit(GetDataError(message: {response.statusCode}.toString()));
      }
    } catch (e) {
      emit(GetDataError(message: 'Failed to load data: $e'));
    }
  }

  void _onFetchDataNewID(FetchNewUser event, Emitter<GetDataState> emit) async {
    emit(GetDataLoading());

    try {
      int randomId;
      do {
        randomId = Random().nextInt(10) + 1; // Generate ID between 1 and 10
      } while (deletedIds.contains(randomId)); // Ensure ID hasn't been deleted

      Uri url = Uri.parse("https://reqres.in/api/users/$randomId");

      var response = await http.get(url);

      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);
        GetSingleUser user = GetSingleUser.fromMap(data);

        emit(GetDataLoaded(user: user));
      } else {
        emit(GetDataError(message: {response.statusCode}.toString()));
      }
    } catch (e) {
      emit(GetDataError(message: 'Failed to load data: $e'));
    }
  }

  void markIdAsDeleted(int id) {
    deletedIds.add(id); // Add ID to deletedIds set
  }
}
