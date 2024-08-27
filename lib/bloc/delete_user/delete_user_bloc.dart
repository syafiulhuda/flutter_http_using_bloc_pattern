import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;

part 'delete_user_event.dart';
part 'delete_user_state.dart';

class DeleteUserBloc extends Bloc<DeleteUserEvent, DeleteUserState> {
  DeleteUserBloc() : super(DeleteUserInitial()) {
    on<DeleteUser>(_deleteUser);
  }

  void _deleteUser(DeleteUser event, Emitter<DeleteUserState> emit) async {
    emit(DeleteUserLoading());

    try {
      Uri url = Uri.parse("https://reqres.in/api/users/${event.id}");

      var response = await http.delete(url);

      if (response.statusCode == 204) {
        emit(DeleteUserLoaded(id: event.id));
      } else {
        emit(const DeleteUserError(message: "Failed to Delete User"));
      }
    } catch (e) {
      emit(DeleteUserError(message: "Error: $e"));
    }
  }
}
