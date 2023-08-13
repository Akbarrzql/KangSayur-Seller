// To parse this JSON data, do
//
//     final deleteDriverModel = deleteDriverModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

DeleteDriverModel deleteDriverModelFromJson(String str) => DeleteDriverModel.fromJson(json.decode(str));

String deleteDriverModelToJson(DeleteDriverModel data) => json.encode(data.toJson());

class DeleteDriverModel {
  final String status;
  final String message;

  DeleteDriverModel({
    required this.status,
    required this.message,
  });

  factory DeleteDriverModel.fromJson(Map<String, dynamic> json) => DeleteDriverModel(
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
  };
}
