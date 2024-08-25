import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_http_request/models/post_user.dart';

import 'package:http/http.dart' as http;

part 'update_data_event.dart';
part 'update_data_state.dart';

class UpdateDataBloc extends Bloc<UpdateDataEvent, UpdateDataState> {
  UpdateDataBloc() : super(UpdateDataInitial()) {
    on<UpdateData>(_updateData);
  }

  void _updateData(UpdateData event, Emitter<UpdateDataState> emit) async {
    emit(UpdateDataLoading());

    try {
      // ! Mengambil userId dari user yang telah dibuat
      Uri url = Uri.parse("https://reqres.in/api/users/${event.user.id}");

      var response = await http.put(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: event.user.toJson(),
      );

      if (response.statusCode == 200 || response.statusCode == 204) {
        Map<String, dynamic> data = json.decode(response.body);

        CreateNewUser updateData = CreateNewUser.fromMap(data);

        emit(UpdateDataLoaded(data: updateData));
      } else {
        emit(const UpdateDataError(message: "Failed to Create Data"));
      }
    } catch (e) {
      emit(UpdateDataError(message: "Failed to Update Data: $e"));
    }
  }
}
