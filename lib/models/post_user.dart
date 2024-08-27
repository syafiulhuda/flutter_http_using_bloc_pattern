import 'dart:convert';

class CreateNewUser {
  final String? id;
  final String? name;
  final String? job;
  final String? createdAt;

  CreateNewUser({
    this.id,
    this.name,
    this.job,
    this.createdAt,
  });

  // ! Response Data
  // {
  //   "name": "morpheus",
  //   "job": "leader",
  //   "id": "708",
  //   "createdAt": "2024-08-24T12:23:47.704Z"
  // }

  factory CreateNewUser.fromJson(String str) =>
      CreateNewUser.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CreateNewUser.fromMap(Map<String, dynamic> json) => CreateNewUser(
        id: json["id"],
        name: json["name"],
        job: json["job"],
        createdAt: json["createdAt"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "job": job,
        "createdAt": createdAt,
      };
}
