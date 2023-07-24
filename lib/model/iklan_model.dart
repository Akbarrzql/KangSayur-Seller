// To parse this JSON data, do
//
//     final iklanModel = iklanModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

IklanModel iklanModelFromJson(String str) => IklanModel.fromJson(json.decode(str));

String iklanModelToJson(IklanModel data) => json.encode(data.toJson());

class IklanModel {
  final String message;
  final Data data;

  IklanModel({
    required this.message,
    required this.data,
  });

  factory IklanModel.fromJson(Map<String, dynamic> json) => IklanModel(
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "data": data.toJson(),
  };
}

class Data {
  final int tokoId;
  final String imgPamflet;
  final String expireThrough;
  final DateTime updatedAt;
  final DateTime createdAt;
  final int id;

  Data({
    required this.tokoId,
    required this.imgPamflet,
    required this.expireThrough,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    tokoId: json["toko_id"],
    imgPamflet: json["img_pamflet"],
    expireThrough: json["expire_through"],
    updatedAt: DateTime.parse(json["updated_at"]),
    createdAt: DateTime.parse(json["created_at"]),
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "toko_id": tokoId,
    "img_pamflet": imgPamflet,
    "expire_through": expireThrough,
    "updated_at": updatedAt.toIso8601String(),
    "created_at": createdAt.toIso8601String(),
    "id": id,
  };
}
