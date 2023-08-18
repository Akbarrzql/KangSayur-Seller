// To parse this JSON data, do
//
//     final validasiEmailModel = validasiEmailModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ValidasiEmailModel validasiEmailModelFromJson(String str) => ValidasiEmailModel.fromJson(json.decode(str));

String validasiEmailModelToJson(ValidasiEmailModel data) => json.encode(data.toJson());

class ValidasiEmailModel {
  final int status;
  final String message;

  ValidasiEmailModel({
    required this.status,
    required this.message,
  });

  factory ValidasiEmailModel.fromJson(Map<String, dynamic> json) => ValidasiEmailModel(
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
  };
}
