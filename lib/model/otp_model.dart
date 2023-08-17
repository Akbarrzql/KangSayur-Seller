// To parse this JSON data, do
//
//     final otpModel = otpModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

OtpModel otpModelFromJson(String str) => OtpModel.fromJson(json.decode(str));

String otpModelToJson(OtpModel data) => json.encode(data.toJson());

class OtpModel {
  final int status;
  final String message;
  final int otp;

  OtpModel({
    required this.status,
    required this.message,
    required this.otp,
  });

  factory OtpModel.fromJson(Map<String, dynamic> json) => OtpModel(
    status: json["status"],
    message: json["message"],
    otp: json["otp"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "otp": otp,
  };
}
