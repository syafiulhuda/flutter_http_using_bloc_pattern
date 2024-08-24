import 'package:flutter/material.dart';
import 'package:flutter_http_request/routes/routes.dart';

class App extends StatelessWidget {
  App({super.key});

  final router = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: router.onGenereteRoute,
    );
  }
}
