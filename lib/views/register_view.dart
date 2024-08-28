import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_http_request/bloc/register_user/register_user_bloc.dart';
import 'package:flutter_http_request/models/register_user.dart';
import 'package:flutter_http_request/views/login_view.dart';
import 'package:flutter_http_request/widgets/app_bar_widget.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    RegisterUserBloc registerUserBloc = context.read<RegisterUserBloc>();

    TextEditingController emailControler = TextEditingController();
    TextEditingController passControler = TextEditingController();

    return Scaffold(
      appBar: const AppBarWidget(
        widget: Text("Register View"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: ListView(
            shrinkWrap: true,
            children: [
              const Center(
                child: Text(
                  "Email: eve.holt@reqres.in",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              const Center(
                child: Text(
                  "Password: pistol",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    controller: emailControler,
                    autocorrect: false,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: "Email",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: passControler,
                    autocorrect: false,
                    obscureText: true,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      labelText: "Password",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  BlocConsumer<RegisterUserBloc, RegisterUserState>(
                    listener: (context, state) {
                      if (state is RegisterUserError) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            duration: const Duration(seconds: 2),
                            content: Text(state.message),
                          ),
                        );
                      } else if (state is RegisterUserLoaded) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            duration: const Duration(seconds: 2),
                            content: Text(
                                "Register Success with Token: ${state.registerUser.token!}"),
                          ),
                        );

                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginView(),
                          ),
                        );
                      }
                    },
                    listenWhen: (previous, current) {
                      return current is RegisterUserError ||
                          current is RegisterUserLoaded;
                    },
                    builder: (context, state) {
                      if (state is RegisterUserLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      return ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.pinkAccent,
                          minimumSize: const Size(
                            double.infinity,
                            50,
                          ),
                        ),
                        onPressed: () {
                          registerUserBloc.add(
                            RegisterUser(
                              registerNewUser: RegisterNewUser(
                                email: emailControler.text,
                                password: passControler.text,
                                // id: 0,
                                // toke: '',
                              ),
                            ),
                          );
                        },
                        child: const Text(
                          "Register",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
