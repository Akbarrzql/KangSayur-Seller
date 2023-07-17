// To parse this JSON data, do
//
//     final konfirmasiModel = konfirmasiModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

KonfirmasiModel konfirmasiModelFromJson(String str) => KonfirmasiModel.fromJson(json.decode(str));

String konfirmasiModelToJson(KonfirmasiModel data) => json.encode(data.toJson());

class KonfirmasiModel {
  final String message;

  KonfirmasiModel({
    required this.message,
  });

  factory KonfirmasiModel.fromJson(Map<String, dynamic> json) => KonfirmasiModel(
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
  };
}
