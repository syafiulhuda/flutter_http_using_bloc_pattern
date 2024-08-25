import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_http_request/bloc/create_data/create_data_bloc.dart';
import 'package:flutter_http_request/bloc/update_data/update_data_bloc.dart';
import 'package:flutter_http_request/models/post_user.dart';
import 'package:flutter_http_request/widgets/app_bar_widget.dart';

class UpdateView extends StatelessWidget {
  const UpdateView({super.key});

  @override
  Widget build(BuildContext context) {
    // ! Mengakses "instance" CreateDataBloc dari context
    CreateDataBloc createDataBloc = context.read<CreateDataBloc>();
    UpdateDataBloc updateDataBloc = context.read<UpdateDataBloc>();

    // ! Controller untuk text field
    TextEditingController nameController = TextEditingController();
    TextEditingController jobController = TextEditingController();

    return Scaffold(
      appBar: const AppBarWidget(title: "Update View"),
      body: BlocConsumer<CreateDataBloc, CreateDataState>(
        listener: (context, state) {
          // ! Menangani perubahan "state" untuk menampilkan SnackBars
          if (state is CreateDataLoaded) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                    "Berhasil Post Data ${state.data.name} - ${state.data.job}"),
              ),
            );
          } else if (state is CreateDataError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
          }
        },
        listenWhen: (previous, current) {
          // ! Menjalakan "listener" dengan kondisi berdasarkan "state"
          return current is CreateDataLoaded || current is CreateDataError;
        },
        builder: (context, state) {
          // ! Menampilkan indikator loading jika "data" sedang dimuat
          if (state is CreateDataLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return ListView(
            padding: const EdgeInsets.all(20),
            children: [
              TextField(
                controller: nameController,
                autocorrect: false,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  labelText: "Name",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: jobController,
                autocorrect: false,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  labelText: "Job",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pinkAccent,
                    ),
                    onPressed: () {
                      createDataBloc.add(
                        CreateUser(
                          user: CreateNewUser(
                            name: nameController.text,
                            job: jobController.text,
                          ),
                        ),
                      );
                    },
                    child: const Text(
                      "Submit",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pinkAccent,
                    ),
                    onPressed: () {
                      // ! Mengambil "id" dari user yang telah dibuat
                      if (createDataBloc.state is CreateDataLoaded) {
                        CreateNewUser createdUser =
                            (createDataBloc.state as CreateDataLoaded).data;

                        updateDataBloc.add(UpdateData(
                            user: CreateNewUser(
                          id: createdUser.id,
                          name: nameController.text,
                          job: jobController.text,
                        )));
                      }
                    },
                    child: const Text(
                      "Update",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              const Divider(
                color: Colors.black,
              ),
              const SizedBox(height: 30),

              // ! Menampilkan data "user" yang telah dibuat atau pesan jika data belum ada
              const Text("Created New User", style: TextStyle(fontSize: 20)),
              if (state is CreateDataLoaded)
                ListTile(
                  shape: UnderlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  tileColor: const Color(0xFFE0E0E0),
                  title: Text(state.data.name),
                  subtitle: Text(state.data.job),
                )
              else
                const Text("Data belum ditambahkan"),

              const SizedBox(height: 30),
              const Text("Updated User", style: TextStyle(fontSize: 20)),
              BlocConsumer<UpdateDataBloc, UpdateDataState>(
                listener: (context, state) {
                  if (state is UpdateDataError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Update Data Error"),
                      ),
                    );
                  } else if (state is UpdateDataLoaded) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Update Data Berhasil"),
                      ),
                    );
                  }
                },
                listenWhen: (previous, current) {
                  return current is UpdateDataLoaded ||
                      current is UpdateDataError;
                },
                builder: (context, state) {
                  if (state is UpdateDataLoaded) {
                    return ListTile(
                      shape: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      tileColor: const Color(0xFFE0E0E0),
                      title: Text(state.data.name),
                      subtitle: Text(state.data.job),
                    );
                  } else {
                    return const Text("Tidak ada data untuk diperbarui");
                  }
                },
              )
            ],
          );
        },
      ),
    );
  }
}
