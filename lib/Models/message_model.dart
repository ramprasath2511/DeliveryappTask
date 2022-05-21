import 'dart:convert';

MessageModel userFromJson(String str) => MessageModel.fromJson(json.decode(str));

String userToJson(MessageModel data) => json.encode(data.toJson());

class MessageModel {
  MessageModel({
    required this.message
  });

  String message;

  factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
  };
}

