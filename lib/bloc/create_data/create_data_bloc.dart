import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_http_request/models/post_user.dart';

import 'package:http/http.dart' as http;

part 'create_data_event.dart';
part 'create_data_state.dart';

class CreateDataBloc extends Bloc<CreateDataEvent, CreateDataState> {
  CreateDataBloc() : super(CreateDataInitial()) {
    on<CreateUser>(_onCreateUser);
  }

  void _onCreateUser(CreateUser event, Emitter<CreateDataState> emit) async {
    emit(CreateDataLoading());

    try {
      Uri url = Uri.parse("https://reqres.in/api/users");

      var response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: event.user.toJson(),
      );

      if (response.statusCode == 201) {
        Map<String, dynamic> data = json.decode(response.body);

        CreateNewUser createdUser = CreateNewUser.fromMap(data);

        emit(CreateDataLoaded(data: createdUser));
      } else {
        emit(const CreateDataError(message: "Failed to Create Data"));
      }
    } catch (e) {
      emit(CreateDataError(message: "Failed to Create Data: $e"));
    }
  }
}
