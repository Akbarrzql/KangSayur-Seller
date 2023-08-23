// To parse this JSON data, do
//
//     final roomChatModelModel = roomChatModelModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

RoomChatModelModel roomChatModelModelFromJson(String str) => RoomChatModelModel.fromJson(json.decode(str));

String roomChatModelModelToJson(RoomChatModelModel data) => json.encode(data.toJson());

class RoomChatModelModel {
  final int status;
  final String message;
  final List<Message> messages;

  RoomChatModelModel({
    required this.status,
    required this.message,
    required this.messages,
  });

  factory RoomChatModelModel.fromJson(Map<String, dynamic> json) => RoomChatModelModel(
    status: json["status"],
    message: json["message"],
    messages: List<Message>.from(json["messages"].map((x) => Message.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "messages": List<dynamic>.from(messages.map((x) => x.toJson())),
  };
}

class Message {
  final int id;
  final int conversationId;
  final int userId;
  final String message;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String name;
  final String photo;
  final String role;
  final bool isCurrentMessage;

  Message({
    required this.id,
    required this.conversationId,
    required this.userId,
    required this.message,
    required this.createdAt,
    required this.updatedAt,
    required this.name,
    required this.photo,
    required this.role,
    required this.isCurrentMessage,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
    id: json["id"],
    conversationId: json["conversation_id"],
    userId: json["user_id"],
    message: json["message"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    name: json["name"],
    photo: json["photo"],
    role: json["role"],
    isCurrentMessage: json["isCurrentMessage"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "conversation_id": conversationId,
    "user_id": userId,
    "message": message,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "name": name,
    "photo": photo,
    "role": role,
    "isCurrentMessage": isCurrentMessage,
  };
}
