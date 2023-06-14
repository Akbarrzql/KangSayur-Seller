// To parse this JSON data, do
//
//     final statusCreateProdukModel = statusCreateProdukModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

StatusCreateProdukModel statusCreateProdukModelFromJson(String str) => StatusCreateProdukModel.fromJson(json.decode(str));

String statusCreateProdukModelToJson(StatusCreateProdukModel data) => json.encode(data.toJson());

class StatusCreateProdukModel {
  String statusCode;
  String message;

  StatusCreateProdukModel({
    required this.statusCode,
    required this.message,
  });

  factory StatusCreateProdukModel.fromJson(Map<String, dynamic> json) => StatusCreateProdukModel(
    statusCode: json["status_code"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status_code": statusCode,
    "message": message,
  };
}
