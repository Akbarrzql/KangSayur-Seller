// To parse this JSON data, do
//
//     final produkModel = produkModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ProdukModel produkModelFromJson(String str) => ProdukModel.fromJson(json.decode(str));

String produkModelToJson(ProdukModel data) => json.encode(data.toJson());

class ProdukModel {
  final String statusCode;
  final String message;
  final List<Datum> data;

  ProdukModel({
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory ProdukModel.fromJson(Map<String, dynamic> json) => ProdukModel(
    statusCode: json["status_code"],
    message: json["message"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status_code": statusCode,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  final String namaProduk;
  final int produkId;
  final String variantImg;
  final int hargaVariant;
  final DateTime tanggalVerivikasi;
  final String status;
  final int stok;
  final List<Variant> variant;
  final int id;

  Datum({
    required this.namaProduk,
    required this.produkId,
    required this.variantImg,
    required this.hargaVariant,
    required this.tanggalVerivikasi,
    required this.status,
    required this.stok,
    required this.variant,
    required this.id,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    namaProduk: json["nama_produk"],
    produkId: json["produk_id"],
    variantImg: json["variant_img"],
    hargaVariant: json["harga_variant"],
    tanggalVerivikasi: DateTime.parse(json["tanggal_verivikasi"]),
    status: json["status"],
    stok: json["stok"],
    variant: List<Variant>.from(json["variant"].map((x) => Variant.fromJson(x))),
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "nama_produk": namaProduk,
    "produk_id": produkId,
    "variant_img": variantImg,
    "harga_variant": hargaVariant,
    "tanggal_verivikasi": tanggalVerivikasi.toIso8601String(),
    "status": status,
    "stok": stok,
    "variant": List<dynamic>.from(variant.map((x) => x.toJson())),
    "id": id,
  };
}

class Variant {
  final int id;
  final int productId;
  final String variantImg;
  final String variant;
  final String variantDesc;
  final int stok;
  final int hargaVariant;
  final DateTime createdAt;
  final DateTime updatedAt;

  Variant({
    required this.id,
    required this.productId,
    required this.variantImg,
    required this.variant,
    required this.variantDesc,
    required this.stok,
    required this.hargaVariant,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Variant.fromJson(Map<String, dynamic> json) => Variant(
    id: json["id"],
    productId: json["product_id"],
    variantImg: json["variant_img"],
    variant: json["variant"],
    variantDesc: json["variant_desc"],
    stok: json["stok"],
    hargaVariant: json["harga_variant"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "product_id": productId,
    "variant_img": variantImg,
    "variant": variant,
    "variant_desc": variantDesc,
    "stok": stok,
    "harga_variant": hargaVariant,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
