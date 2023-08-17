// To parse this JSON data, do
//
//     final resetPasswordSellerModel = resetPasswordSellerModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ResetPasswordSellerModel resetPasswordSellerModelFromJson(String str) => ResetPasswordSellerModel.fromJson(json.decode(str));

String resetPasswordSellerModelToJson(ResetPasswordSellerModel data) => json.encode(data.toJson());

class ResetPasswordSellerModel {
  final int status;
  final String message;

  ResetPasswordSellerModel({
    required this.status,
    required this.message,
  });

  factory ResetPasswordSellerModel.fromJson(Map<String, dynamic> json) => ResetPasswordSellerModel(
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
  };
}
