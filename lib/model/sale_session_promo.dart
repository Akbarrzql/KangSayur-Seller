// To parse this JSON data, do
//
//     final saleSessionPromoModel = saleSessionPromoModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

SaleSessionPromoModel saleSessionPromoModelFromJson(String str) => SaleSessionPromoModel.fromJson(json.decode(str));

String saleSessionPromoModelToJson(SaleSessionPromoModel data) => json.encode(data.toJson());

class SaleSessionPromoModel {
  final String status;
  final String message;
  final List<Datum> data;

  SaleSessionPromoModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory SaleSessionPromoModel.fromJson(Map<String, dynamic> json) => SaleSessionPromoModel(
    status: json["status"],
    message: json["message"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  final int id;
  final String start;
  final String end;

  Datum({
    required this.id,
    required this.start,
    required this.end,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    start: json["start"],
    end: json["end"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "start": start,
    "end": end,
  };
}
