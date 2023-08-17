// To parse this JSON data, do
//
//     final verifyOtpModel = verifyOtpModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

VerifyOtpModel verifyOtpModelFromJson(String str) => VerifyOtpModel.fromJson(json.decode(str));

String verifyOtpModelToJson(VerifyOtpModel data) => json.encode(data.toJson());

class VerifyOtpModel {
  final int status;
  final String message;
  final String statusVerifikasi;

  VerifyOtpModel({
    required this.status,
    required this.message,
    required this.statusVerifikasi,
  });

  factory VerifyOtpModel.fromJson(Map<String, dynamic> json) => VerifyOtpModel(
    status: json["status"],
    message: json["message"],
    statusVerifikasi: json["status_verifikasi"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "status_verifikasi": statusVerifikasi,
  };
}
