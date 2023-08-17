// To parse this JSON data, do
//
//     final ubahPasswordDriverModel = ubahPasswordDriverModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

UbahPasswordDriverModel ubahPasswordDriverModelFromJson(String str) => UbahPasswordDriverModel.fromJson(json.decode(str));

String ubahPasswordDriverModelToJson(UbahPasswordDriverModel data) => json.encode(data.toJson());

class UbahPasswordDriverModel {
  final int status;
  final String message;

  UbahPasswordDriverModel({
    required this.status,
    required this.message,
  });

  factory UbahPasswordDriverModel.fromJson(Map<String, dynamic> json) => UbahPasswordDriverModel(
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
  };
}
