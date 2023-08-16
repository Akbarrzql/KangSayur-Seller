// To parse this JSON data, do
//
//     final saleModel = saleModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

SaleModel saleModelFromJson(String str) => SaleModel.fromJson(json.decode(str));

String saleModelToJson(SaleModel data) => json.encode(data.toJson());

class SaleModel {
  final String status;
  final String message;

  SaleModel({
    required this.status,
    required this.message,
  });

  factory SaleModel.fromJson(Map<String, dynamic> json) => SaleModel(
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
  };
}
