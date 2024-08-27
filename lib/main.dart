import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_http_request/app.dart';
import 'package:flutter_http_request/bloc/create_data/create_data_bloc.dart';
import 'package:flutter_http_request/bloc/delete_user/delete_user_bloc.dart';
import 'package:flutter_http_request/bloc/get_data/get_data_bloc.dart';
import 'package:flutter_http_request/bloc/get_list_data/get_list_data_bloc.dart';
import 'package:flutter_http_request/bloc/login/login_bloc.dart';
import 'package:flutter_http_request/bloc/register_user/register_user_bloc.dart';
import 'package:flutter_http_request/bloc/update_data/update_data_bloc.dart';

// ! Handling CERTIFICATE_VERIFY_FAILED
class CertificateVerify extends HttpOverrides {
  @override
  HttpClient createHttpClient(context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  HttpOverrides.global = CertificateVerify();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => RegisterUserBloc(),
        ),
        BlocProvider(
          create: (context) => LoginBloc(),
        ),
        BlocProvider(
          create: (context) => GetDataBloc(),
        ),
        BlocProvider(
          create: (context) => GetListDataBloc(),
        ),
        BlocProvider(
          create: (context) => CreateDataBloc(),
        ),
        BlocProvider(
          create: (context) => UpdateDataBloc(),
        ),
        BlocProvider(
          create: (context) => DeleteUserBloc(),
        ),
      ],
      child: App(),
    );
  }
}
