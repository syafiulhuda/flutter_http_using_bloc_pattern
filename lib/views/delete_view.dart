import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_http_request/bloc/delete_user/delete_user_bloc.dart';
import 'package:flutter_http_request/bloc/get_data/get_data_bloc.dart';
import 'package:flutter_http_request/bloc/get_list_data/get_list_data_bloc.dart';
import 'package:flutter_http_request/widgets/app_bar_widget.dart';

class DeleteView extends StatelessWidget {
  const DeleteView({super.key});

  @override
  Widget build(BuildContext context) {
    DeleteUserBloc deleteUserBloc = context.read<DeleteUserBloc>();
    GetListDataBloc getListDataBloc = context.read<GetListDataBloc>();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (getListDataBloc.state is GetListDataInitial) {
        getListDataBloc.add(const FetchListData());
      }
    });

    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: const AppBarWidget(
        widget: Text(
          "Delete View",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<DeleteUserBloc, DeleteUserState>(
            listener: (context, state) {
              if (state is DeleteUserLoaded) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    duration: const Duration(seconds: 1),
                    content: Text("ID ${state.id} berhasil dihapus"),
                  ),
                );
                getListDataBloc
                    .add(const FetchListData()); // Panggil FetchListData
              } else if (state is DeleteUserError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    duration: const Duration(seconds: 1),
                    content: Text("Error: ${state.message}"),
                  ),
                );
              }
            },
          ),
          BlocListener<GetListDataBloc, GetListDataState>(
            listener: (context, state) {
              if (state is GetListDataError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    duration: const Duration(seconds: 1),
                    content: Text(state.message),
                  ),
                );
              } else if (state is GetListDataLoaded) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    duration: Duration(seconds: 1),
                    content: Text("Data terupdate"),
                  ),
                );
              }
            },
            listenWhen: (previous, current) {
              return current is GetListDataError || current is GetDataLoaded;
            },
          ),
        ],
        child: BlocBuilder<GetListDataBloc, GetListDataState>(
          builder: (context, state) {
            if (state is GetListDataLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is GetListDataLoaded) {
              return ListView.builder(
                itemCount: state.data.data.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.all(screenWidth * 0.03),
                    child: ListTile(
                      tileColor: Colors.greenAccent,
                      leading: Text(
                        state.data.data[index].id.toString(),
                        style: const TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      title: Text(
                        "${state.data.data[index].firstName} ${state.data.data[index].lastName}",
                      ),
                      subtitle: Text(state.data.data[index].email),
                      trailing: IconButton(
                        onPressed: () {
                          final userID = state.data.data[index].id;
                          deleteUserBloc.add(DeleteUser(id: userID));

                          // ! Masukkan ID yang telah dihapus ke dalam SET _deletedIds
                          getListDataBloc.markAsDeleted(userID);
                        },
                        icon: const Icon(Icons.delete),
                      ),
                    ),
                  );
                },
              );
            } else {
              return const Center(
                child: Text("Klik tombol untuk memuat data!"),
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // ! Hapus ID yang telah dihapus dari SET _deletedIds
          getListDataBloc.clearDeleteIds();

          // ! Baru panggil FetchListData
          getListDataBloc.add(const FetchListData());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
