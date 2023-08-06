// To parse this JSON data, do
//
//     final verifikasiModel = verifikasiModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

VerifikasiModel verifikasiModelFromJson(String str) => VerifikasiModel.fromJson(json.decode(str));

String verifikasiModelToJson(VerifikasiModel data) => json.encode(data.toJson());

class VerifikasiModel {
  final String statusCode;
  final String message;
  final List<Datum> data;

  VerifikasiModel({
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory VerifikasiModel.fromJson(Map<String, dynamic> json) => VerifikasiModel(
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
  final String variant;

  Datum({
    required this.namaProduk,
    required this.produkId,
    required this.variantImg,
    required this.hargaVariant,
    required this.tanggalVerivikasi,
    required this.status,
    required this.stok,
    required this.variant,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    namaProduk: json["nama_produk"],
    produkId: json["produk_id"],
    variantImg: json["variant_img"],
    hargaVariant: json["harga_variant"],
    tanggalVerivikasi: DateTime.parse(json["tanggal_verivikasi"]),
    status: json["status"],
    stok: json["stok"],
    variant: json["variant"],
  );

  Map<String, dynamic> toJson() => {
    "nama_produk": namaProduk,
    "produk_id": produkId,
    "variant_img": variantImg,
    "harga_variant": hargaVariant,
    "tanggal_verivikasi": tanggalVerivikasi.toIso8601String(),
    "status": status,
    "stok": stok,
    "variant": variant,
  };
}
