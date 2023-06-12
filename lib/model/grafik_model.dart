// To parse this JSON data, do
//
//     final grafikModel = grafikModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

GrafikModel grafikModelFromJson(String str) => GrafikModel.fromJson(json.decode(str));

String grafikModelToJson(GrafikModel data) => json.encode(data.toJson());

class GrafikModel {
  int status;
  List<GrafikPenjualan> grafikPenjualan;

  GrafikModel({
    required this.status,
    required this.grafikPenjualan,
  });

  factory GrafikModel.fromJson(Map<String, dynamic> json) => GrafikModel(
    status: json["status"],
    grafikPenjualan: List<GrafikPenjualan>.from(json["grafik_penjualan"].map((x) => GrafikPenjualan.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "grafik_penjualan": List<dynamic>.from(grafikPenjualan.map((x) => x.toJson())),
  };
}

class GrafikPenjualan {
  String date;
  int total;

  GrafikPenjualan({
    required this.date,
    required this.total,
  });

  factory GrafikPenjualan.fromJson(Map<String, dynamic> json) => GrafikPenjualan(
    date: json["date"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "date": date,
    "total": total,
  };
}
