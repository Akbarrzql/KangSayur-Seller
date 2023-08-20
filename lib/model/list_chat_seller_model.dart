// To parse this JSON data, do
//
//     final listChatSellerModel = listChatSellerModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ListChatSellerModel listChatSellerModelFromJson(String str) => ListChatSellerModel.fromJson(json.decode(str));

String listChatSellerModelToJson(ListChatSellerModel data) => json.encode(data.toJson());

class ListChatSellerModel {
  final int status;
  final String message;
  final List<ListElement> list;

  ListChatSellerModel({
    required this.status,
    required this.message,
    required this.list,
  });

  factory ListChatSellerModel.fromJson(Map<String, dynamic> json) => ListChatSellerModel(
    status: json["status"],
    message: json["message"],
    list: List<ListElement>.from(json["list"].map((x) => ListElement.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "list": List<dynamic>.from(list.map((x) => x.toJson())),
  };
}

class ListElement {
  final int userId;
  final String name;
  final String photo;
  final int conversationId;
  final LastConvo lastConvo;

  ListElement({
    required this.userId,
    required this.name,
    required this.photo,
    required this.conversationId,
    required this.lastConvo,
  });

  factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
    userId: json["user_id"],
    name: json["name"],
    photo: json["photo"],
    conversationId: json["conversation_id"],
    lastConvo: LastConvo.fromJson(json["lastConvo"]),
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "name": name,
    "photo": photo,
    "conversation_id": conversationId,
    "lastConvo": lastConvo.toJson(),
  };
}

class LastConvo {
  final int id;
  final int conversationId;
  final int userId;
  final String message;
  final DateTime createdAt;
  final DateTime updatedAt;

  LastConvo({
    required this.id,
    required this.conversationId,
    required this.userId,
    required this.message,
    required this.createdAt,
    required this.updatedAt,
  });

  factory LastConvo.fromJson(Map<String, dynamic> json) => LastConvo(
    id: json["id"],
    conversationId: json["conversation_id"],
    userId: json["user_id"],
    message: json["message"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "conversation_id": conversationId,
    "user_id": userId,
    "message": message,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
