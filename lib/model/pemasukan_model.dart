// To parse this JSON data, do
//
//     final pemasukanModel = pemasukanModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

PemasukanModel pemasukanModelFromJson(String str) => PemasukanModel.fromJson(json.decode(str));

String pemasukanModelToJson(PemasukanModel data) => json.encode(data.toJson());

class PemasukanModel {
  int status;
  Pemasukan pemasukan;

  PemasukanModel({
    required this.status,
    required this.pemasukan,
  });

  factory PemasukanModel.fromJson(Map<String, dynamic> json) => PemasukanModel(
    status: json["status"],
    pemasukan: Pemasukan.fromJson(json["pemasukan"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "pemasukan": pemasukan.toJson(),
  };
}

class Pemasukan {
  int totalKeseluruhan;
  int pemasukanPilihan;

  Pemasukan({
    required this.totalKeseluruhan,
    required this.pemasukanPilihan,
  });

  factory Pemasukan.fromJson(Map<String, dynamic> json) => Pemasukan(
    totalKeseluruhan: json["total_keseluruhan"] ?? 0,
    pemasukanPilihan: json["pemasukan_pilihan"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "total_keseluruhan": totalKeseluruhan,
    "pemasukan_pilihan": pemasukanPilihan,
  };
}
