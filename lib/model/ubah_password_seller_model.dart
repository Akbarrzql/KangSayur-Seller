// To parse this JSON data, do
//
//     final ubahPasswordSellerModel = ubahPasswordSellerModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

UbahPasswordSellerModel ubahPasswordSellerModelFromJson(String str) => UbahPasswordSellerModel.fromJson(json.decode(str));

String ubahPasswordSellerModelToJson(UbahPasswordSellerModel data) => json.encode(data.toJson());

class UbahPasswordSellerModel {
  final int status;
  final String message;

  UbahPasswordSellerModel({
    required this.status,
    required this.message,
  });

  factory UbahPasswordSellerModel.fromJson(Map<String, dynamic> json) => UbahPasswordSellerModel(
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
  };
}
