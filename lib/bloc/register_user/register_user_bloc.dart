// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_http_request/models/register_user.dart';

import 'package:http/http.dart' as http;

part 'register_user_event.dart';
part 'register_user_state.dart';

class RegisterUserBloc extends Bloc<RegisterUserEvent, RegisterUserState> {
  RegisterUserBloc() : super(RegisterUserInitial()) {
    on<RegisterUser>(_registerUser);
  }

  void _registerUser(
      RegisterUser event, Emitter<RegisterUserState> emit) async {
    emit(RegisterUserLoading());

    try {
      Uri url = Uri.parse("https://reqres.in/api/register");

      var response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: event.registerNewUser.toJson(),
      );

      if (response.statusCode == 200) {
        print('Response status: ${response.statusCode}');
        print('Response body: ${response.body}');

        Map<String, dynamic> data = json.decode(response.body);

        if (data.containsKey('token') && data['token'] != null) {
          RegisterNewUser user = RegisterNewUser.fromMap(data);

          emit(RegisterUserLoaded(registerUser: user));
        } else {
          emit(const RegisterUserError(message: "Token not found in response"));
        }
      } else {
        emit(const RegisterUserError(message: "Failed to register"));
      }
    } catch (e) {
      emit(
        RegisterUserError(message: "Failed to register: $e"),
      );
    }
  }
}
