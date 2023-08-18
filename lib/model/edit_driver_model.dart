// To parse this JSON data, do
//
//     final editDriverModel = editDriverModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

EditDriverModel editDriverModelFromJson(String str) => EditDriverModel.fromJson(json.decode(str));

String editDriverModelToJson(EditDriverModel data) => json.encode(data.toJson());

class EditDriverModel {
  final int status;
  final String message;

  EditDriverModel({
    required this.status,
    required this.message,
  });

  factory EditDriverModel.fromJson(Map<String, dynamic> json) => EditDriverModel(
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
  };
}
