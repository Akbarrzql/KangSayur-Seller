// To parse this JSON data, do
//
//     final sendMassageModel = sendMassageModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

SendMassageModel sendMassageModelFromJson(String str) => SendMassageModel.fromJson(json.decode(str));

String sendMassageModelToJson(SendMassageModel data) => json.encode(data.toJson());

class SendMassageModel {
  final int status;
  final String message;

  SendMassageModel({
    required this.status,
    required this.message,
  });

  factory SendMassageModel.fromJson(Map<String, dynamic> json) => SendMassageModel(
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
  };
}
