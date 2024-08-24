import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_http_request/bloc/create_data/create_data_bloc.dart';

import 'package:flutter_http_request/bloc/get_data/get_data_bloc.dart';
import 'package:flutter_http_request/views/get_view.dart';
import 'package:flutter_http_request/views/home_page.dart';
import 'package:flutter_http_request/views/not_found_view.dart';
import 'package:flutter_http_request/views/post_view.dart';

class AppRouter {
  // ! Untuk Generated Route
  // ! Inject semua routes dengan BlocProvider yang sama
  final GetDataBloc blocViaGenerateRoute = GetDataBloc();
  final CreateDataBloc createDataBloc = CreateDataBloc();

  Route onGenereteRoute(RouteSettings settings) {
    switch (settings.name) {
      case "/":
        return MaterialPageRoute(
          builder: (context) => const HomePage(),
        );
      case "/get":
        return MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: blocViaGenerateRoute,
            child: const GetUserView(),
          ),
        );
      case "/post":
        return MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: createDataBloc,
            child: const PostView(),
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (context) => const NotFoundView(),
        );
    }
  }
}