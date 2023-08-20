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
  final Interlocutors interlocutors;
  final List<Message> messages;

  RoomChatModelModel({
    required this.status,
    required this.message,
    required this.interlocutors,
    required this.messages,
  });

  factory RoomChatModelModel.fromJson(Map<String, dynamic> json) => RoomChatModelModel(
    status: json["status"],
    message: json["message"],
    interlocutors: Interlocutors.fromJson(json["interlocutors"]),
    messages: List<Message>.from(json["messages"].map((x) => Message.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "interlocutors": interlocutors.toJson(),
    "messages": List<dynamic>.from(messages.map((x) => x.toJson())),
  };
}

class Interlocutors {
  final int id;
  final String name;
  final String photo;
  final String email;
  final int phoneNumber;
  final String emailVerifiedAt;
  final int sandiId;
  final int jenisKelamin;
  final DateTime tanggalLahir;
  final String address;
  final double longitude;
  final double latitude;
  final String deviceToken;
  final DateTime createdAt;
  final DateTime updatedAt;

  Interlocutors({
    required this.id,
    required this.name,
    required this.photo,
    required this.email,
    required this.phoneNumber,
    required this.emailVerifiedAt,
    required this.sandiId,
    required this.jenisKelamin,
    required this.tanggalLahir,
    required this.address,
    required this.longitude,
    required this.latitude,
    required this.deviceToken,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Interlocutors.fromJson(Map<String, dynamic> json) => Interlocutors(
    id: json["id"],
    name: json["name"],
    photo: json["photo"],
    email: json["email"],
    phoneNumber: json["phone_number"],
    emailVerifiedAt: json["email_verified_at"],
    sandiId: json["sandi_id"],
    jenisKelamin: json["jenis_kelamin"],
    tanggalLahir: DateTime.parse(json["tanggal_lahir"]),
    address: json["address"],
    longitude: json["longitude"]?.toDouble(),
    latitude: json["latitude"]?.toDouble(),
    deviceToken: json["device_token"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "photo": photo,
    "email": email,
    "phone_number": phoneNumber,
    "email_verified_at": emailVerifiedAt,
    "sandi_id": sandiId,
    "jenis_kelamin": jenisKelamin,
    "tanggal_lahir": tanggalLahir.toIso8601String(),
    "address": address,
    "longitude": longitude,
    "latitude": latitude,
    "device_token": deviceToken,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
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
