import 'dart:convert';

class RegisterNewUser {
  final String email;
  final String password;
  final int? id; // nullable
  final String? token; // nullable

  RegisterNewUser({
    required this.email,
    required this.password,
    this.id,
    this.token,
  });

  factory RegisterNewUser.fromJson(String str) =>
      RegisterNewUser.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory RegisterNewUser.fromMap(Map<String, dynamic> json) => RegisterNewUser(
        email: json['email'] ?? '',
        password: json['password'] ?? '',
        id: json['id'] ?? 0,
        token: json['token'] ?? '', // nullable
      );

  Map<String, dynamic> toMap() => {
        "email": email,
        "password": password,
        "id": id,
        "token": token,
      };
}
