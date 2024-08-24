// ignore_for_file: unused_import

import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_http_request/models/get_single_user.dart';
import 'package:flutter_http_request/models/post_user.dart';
import 'package:http/io_client.dart';
import 'package:http/http.dart' as http;

part 'get_data_event.dart';
part 'get_data_state.dart';

class GetDataBloc extends Bloc<GetDataEvent, GetDataState> {
  GetDataBloc() : super(GetDataInitial()) {
    // !
    // ? Use the code
    on<FetchUser>(_onFetchDataViaHttp);
  }

  // !
  // ? Init data
  void _onFetchDataViaHttp(FetchUser event, Emitter<GetDataState> emit) async {
    emit(GetDataLoading());

    // !
    // ? set up HTTP Method
    try {
      int randomId = Random().nextInt(12) + 1;
      Uri url = Uri.parse("https://reqres.in/api/users/$randomId");

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
}
