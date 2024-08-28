// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_http_request/bloc/login/login_bloc.dart';
import 'package:flutter_http_request/models/register_user.dart';
import 'package:flutter_http_request/widgets/app_bar_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Future<String?> _getEmail() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString('email');
  }

  // Future<String?> _getPassword() async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   return preferences.getString('password');
  // }

  @override
  Widget build(BuildContext context) {
    // ! Routes
    final List<Map<String, String>> routes = [
      {"name": "Get User", "route": "/get"},
      {"name": "Post Data", "route": "/post"},
      {"name": "Update Data", "route": "/update"},
      {"name": "Delete Data", "route": "/delete"},
    ];

    // make list of image
    final List<Map<String, String>> images = [
      {
        "name": "Get Logo",
        "image": "assets/get.png",
      },
      {
        "name": "Post Logo",
        "image": "assets/post.png",
      },
      {
        "name": "Update Logo",
        "image": "assets/update.png",
      },
      {
        "name": "Delete Logo",
        "image": "assets/delete.png",
      },
    ];

    // ! Screen Width
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBarWidget(
        widget: FutureBuilder<String?>(
          future: _getEmail(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text("Loading...");
            } else if (snapshot.hasData && snapshot.data != null) {
              String? email = snapshot.data;
              String displayName =
                  email != null ? email.split('@')[0] : "Tidak ada data";
              return Text("Hai $displayName");
            } else {
              return const Text("Tidak ada data");
            }
          },
        ),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 3 / 4,
        ),
        itemCount: routes.length,
        itemBuilder: (context, index) {
          final route = routes[index];
          final image = images[index];

          return Padding(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.03,
              vertical: screenWidth * 0.03,
            ),
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  route["route"]!,
                );
              },
              child: Card(
                color: Colors.grey.shade300,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                elevation: 4,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.03,
                    vertical: screenWidth * 0.03,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(16),
                          ),
                          child: Image.asset(
                            image['image']!,
                            fit: BoxFit.contain,
                            width: double.infinity,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          route['name']!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
      // ListView.separated(
      //   padding: EdgeInsets.only(top: padding),
      //   itemCount: routes.length,
      //   separatorBuilder: (context, index) => Padding(
      //     padding: EdgeInsets.symmetric(horizontal: padding),
      //     child: const Divider(color: Colors.black),
      //   ),
      //   itemBuilder: (context, index) {
      //     final route = routes[index];
      //     final image = images[index];

      //     return Padding(
      //       padding: EdgeInsets.symmetric(horizontal: padding),
      //       child: ListTile(
      //         leading: Image.asset(image['image']!),
      //         tileColor: const Color(0xFFE0E0E0),
      //         splashColor: Colors.blueGrey,
      //         title: Text(route['name']!),
      //         onTap: () {
      //           Navigator.pushNamed(context, route['route']!);
      //         },
      //       ),
      //     );
      //   },
      // ),
    );
  }
}
