// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_http_request/widgets/app_bar_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // ! Routes
    final List<Map<String, String>> routes = [
      {"name": "Get User", "route": "/get"},
      {"name": "Post Data", "route": "/post"},
    ];

    // ! Screen Width
    final screenWidth = MediaQuery.of(context).size.width;
    final padding = screenWidth * 0.03;

    return Scaffold(
      appBar: const AppBarWidget(
        title: "Home Page",
      ),
      body: ListView.separated(
        padding: EdgeInsets.only(top: padding),
        itemCount: routes.length,
        separatorBuilder: (context, index) => Padding(
          padding: EdgeInsets.symmetric(horizontal: padding),
          child: const Divider(color: Colors.black),
        ),
        itemBuilder: (context, index) {
          final route = routes[index];

          return Padding(
            padding: EdgeInsets.symmetric(horizontal: padding),
            child: ListTile(
              tileColor: const Color(0xFFE0E0E0),
              splashColor: Colors.blueGrey,
              title: Text(route['name']!),
              onTap: () {
                Navigator.pushNamed(context, route['route']!);
              },
            ),
          );
        },
      ),
    );
  }
}
