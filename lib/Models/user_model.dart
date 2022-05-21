import 'dart:convert';

UserModel userFromJson(String str) => UserModel.fromJson(json.decode(str));

String userToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    required this.roles,
    required this.token,
  });

  List<String> roles;
  String token;


  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    roles: List<String>.from(json["roles"].map((x) => x)),
    token: json["token"],

  );

  Map<String, dynamic> toJson() => {
    "roles": List<dynamic>.from(roles.map((x) => x)),
    "token": token,
  };
}