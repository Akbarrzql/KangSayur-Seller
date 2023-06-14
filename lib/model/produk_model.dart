// To parse this JSON data, do
//
//     final produkModel = produkModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ProdukModel produkModelFromJson(String str) => ProdukModel.fromJson(json.decode(str));

String produkModelToJson(ProdukModel data) => json.encode(data.toJson());

class ProdukModel {
  String statusCode;
  String message;
  List<Datum> data;

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
  String namaProduk;
  int produkId;
  dynamic variantImg;
  int hargaVariant;
  DateTime tanggalVerivikasi;
  String status;
  int stok;

  Datum({
    required this.namaProduk,
    required this.produkId,
    required this.variantImg,
    required this.hargaVariant,
    required this.tanggalVerivikasi,
    required this.status,
    required this.stok,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    namaProduk: json["nama_produk"],
    produkId: json["produk_id"],
    variantImg: json["variant_img"],
    hargaVariant: json["harga_variant"],
    tanggalVerivikasi: DateTime.parse(json["tanggal_verivikasi"]),
    status: json["status"],
    stok: json["stok"],
  );

  Map<String, dynamic> toJson() => {
    "nama_produk": namaProduk,
    "produk_id": produkId,
    "variant_img": variantImg,
    "harga_variant": hargaVariant,
    "tanggal_verivikasi": tanggalVerivikasi.toIso8601String(),
    "status": status,
    "stok": stok,
  };
}
