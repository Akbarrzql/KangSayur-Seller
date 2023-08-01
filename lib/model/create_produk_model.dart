// To parse this JSON data, do
//
//     final createProdukModel = createProdukModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

CreateProdukModel createProdukModelFromJson(String str) => CreateProdukModel.fromJson(json.decode(str));

String createProdukModelToJson(CreateProdukModel data) => json.encode(data.toJson());

class CreateProdukModel {
  final String statusCode;
  final String message;
  final Data data;

  CreateProdukModel({
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory CreateProdukModel.fromJson(Map<String, dynamic> json) => CreateProdukModel(
    statusCode: json["status_code"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status_code": statusCode,
    "message": message,
    "data": data.toJson(),
  };
}

class Data {
  final int productId;
  final String variant;
  final String variantDesc;
  final String stok;
  final String variantImg;
  final String hargaVariant;
  final DateTime updatedAt;
  final DateTime createdAt;
  final int id;

  Data({
    required this.productId,
    required this.variant,
    required this.variantDesc,
    required this.stok,
    required this.variantImg,
    required this.hargaVariant,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    productId: json["product_id"],
    variant: json["variant"],
    variantDesc: json["variant_desc"],
    stok: json["stok"],
    variantImg: json["variant_img"],
    hargaVariant: json["harga_variant"],
    updatedAt: DateTime.parse(json["updated_at"]),
    createdAt: DateTime.parse(json["created_at"]),
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "product_id": productId,
    "variant": variant,
    "variant_desc": variantDesc,
    "stok": stok,
    "variant_img": variantImg,
    "harga_variant": hargaVariant,
    "updated_at": updatedAt.toIso8601String(),
    "created_at": createdAt.toIso8601String(),
    "id": id,
  };
}
