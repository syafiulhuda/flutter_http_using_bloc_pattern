import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_http_request/bloc/get_data/get_data_bloc.dart';
import 'package:flutter_http_request/widgets/app_bar_widget.dart';

class GetUserView extends StatelessWidget {
  const GetUserView({super.key});

  @override
  Widget build(BuildContext context) {
    GetDataBloc getDataBloc = context.read<GetDataBloc>();

    // ! Dijalankan pertama kali
    // ! Jalankan event FetchUser setelah frame pertama dirender
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (getDataBloc.state is GetDataInitial) {
        getDataBloc.add(FetchUser());
      }
    });

    return Scaffold(
      appBar: const AppBarWidget(
        widget: Text(
          "Get User View",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: BlocConsumer<GetDataBloc, GetDataState>(
        listener: (context, state) {
          if (state is GetDataError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          } else if (state is GetDataLoaded) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("ID: ${state.user.data.id}"),
              ),
            );
          }
        },
        listenWhen: (previous, current) {
          // ! Ini dijalankan berdasarkan kondisi state (listener)
          return current is GetDataLoaded || current is GetDataError;
        },
        builder: (context, state) {
          if (state is GetDataLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is GetDataLoaded) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 100,
                    backgroundImage: NetworkImage(
                      state.user.data.avatar,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "userID: ${state.user.data.id}",
                        style: const TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(width: 20),
                      Text(
                        state.user.data.email,
                        style: const TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "${state.user.data.firstName} ${state.user.data.lastName}",
                    style: const TextStyle(fontSize: 20),
                  ),
                  const SizedBox(height: 20),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.attach_money, size: 24),
                      SizedBox(width: 10),
                      Text('₹1', style: TextStyle(fontSize: 20)),
                      SizedBox(width: 20),
                      Icon(Icons.check, size: 24),
                      SizedBox(width: 10),
                      Text('Bank', style: TextStyle(fontSize: 20)),
                      SizedBox(width: 20),
                      Icon(Icons.arrow_forward, size: 24),
                    ],
                  ),
                ],
              ),
            );
          } else {
            return const Center(child: Text("Click Button Please!"));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // ! Yang di add() itu "event"
          getDataBloc.add(FetchUser());
        },
        child: const Icon(Icons.download),
      ),
    );
  }
}
