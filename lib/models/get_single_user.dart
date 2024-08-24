import 'dart:convert';

class GetSingleUser {
  final Data data;
  final Support support;

  GetSingleUser({
    required this.data,
    required this.support,
  });

  factory GetSingleUser.fromJson(String str) =>
      GetSingleUser.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetSingleUser.fromMap(Map<String, dynamic> json) => GetSingleUser(
        data: Data.fromMap(json["data"]),
        support: Support.fromMap(json["support"]),
      );

  Map<String, dynamic> toMap() => {
        "data": data.toMap(),
        "support": support.toMap(),
      };
}

class Data {
  final int id;
  final String email;
  final String firstName;
  final String lastName;
  final String avatar;

  Data({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.avatar,
  });

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        id: json["id"],
        email: json["email"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        avatar: json["avatar"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "email": email,
        "first_name": firstName,
        "last_name": lastName,
        "avatar": avatar,
      };
}

class Support {
  final String url;
  final String text;

  Support({
    required this.url,
    required this.text,
  });

  factory Support.fromJson(String str) => Support.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Support.fromMap(Map<String, dynamic> json) => Support(
        url: json["url"],
        text: json["text"],
      );

  Map<String, dynamic> toMap() => {
        "url": url,
        "text": text,
      };
}
