// To parse this JSON data, do
//
//     final editSellerModel = editSellerModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

EditSellerModel editSellerModelFromJson(String str) => EditSellerModel.fromJson(json.decode(str));

String editSellerModelToJson(EditSellerModel data) => json.encode(data.toJson());

class EditSellerModel {
  final String status;
  final String message;

  EditSellerModel({
    required this.status,
    required this.message,
  });

  factory EditSellerModel.fromJson(Map<String, dynamic> json) => EditSellerModel(
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
  };
}
