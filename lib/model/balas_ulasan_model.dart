// To parse this JSON data, do
//
//     final balasUlasanSellerModel = balasUlasanSellerModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

BalasUlasanSellerModel balasUlasanSellerModelFromJson(String str) => BalasUlasanSellerModel.fromJson(json.decode(str));

String balasUlasanSellerModelToJson(BalasUlasanSellerModel data) => json.encode(data.toJson());

class BalasUlasanSellerModel {
  final String status;
  final String message;
  final String reply;

  BalasUlasanSellerModel({
    required this.status,
    required this.message,
    required this.reply,
  });

  factory BalasUlasanSellerModel.fromJson(Map<String, dynamic> json) => BalasUlasanSellerModel(
    status: json["status"],
    message: json["message"],
    reply: json["reply"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "reply": reply,
  };
}
