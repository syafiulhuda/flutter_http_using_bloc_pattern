// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_http_request/models/post_user.dart';
import 'package:flutter_http_request/models/register_user.dart';

import 'package:http/http.dart' as http;

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginUser>(_loginUser);
  }

  void _loginUser(LoginUser event, Emitter<LoginState> emit) async {
    emit(LoginLoading());

    try {
      Uri url = Uri.parse("https://reqres.in/api/login");

      var response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: event.loginUser.toJson(),
      );

      Map<String, dynamic> data = json.decode(response.body);

      if (response.statusCode == 200 ||
          data.containsKey('token') ||
          data['token'] != null) {
        print('Response status: ${response.statusCode}');
        print('Response body: ${response.body}');

        RegisterNewUser loginData = RegisterNewUser.fromMap(data);

        emit(LoginSuccess(userLogin: loginData));
      } else {
        emit(const LoginError(message: "Failed to Login"));
      }
    } catch (e) {
      emit(LoginError(message: "Error: $e"));
    }
  }
}
