// To parse this JSON data, do
//
//     final verifikasiModel = verifikasiModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

VerifikasiModel verifikasiModelFromJson(String str) => VerifikasiModel.fromJson(json.decode(str));

String verifikasiModelToJson(VerifikasiModel data) => json.encode(data.toJson());

class VerifikasiModel {
  String statusCode;
  String message;
  List<Datum> data;

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
  int id;
  String namaToko;
  String namaProduk;
  String alamat;
  dynamic variantImg;
  int hargaVariant;
  int stok;
  String deskripsi;
  DateTime tanggalVerivikasi;
  String status;

  Datum({
    required this.id,
    required this.namaToko,
    required this.namaProduk,
    required this.alamat,
    required this.variantImg,
    required this.hargaVariant,
    required this.stok,
    required this.deskripsi,
    required this.tanggalVerivikasi,
    required this.status,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    namaToko: json["nama_toko"],
    namaProduk: json["nama_produk"],
    alamat: json["alamat"],
    variantImg: json["variant_img"],
    hargaVariant: json["harga_variant"],
    stok: json["stok"],
    deskripsi: json["deskripsi"],
    tanggalVerivikasi: DateTime.parse(json["tanggal_verivikasi"]),
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "nama_toko": namaToko,
    "nama_produk": namaProduk,
    "alamat": alamat,
    "variant_img": variantImg,
    "harga_variant": hargaVariant,
    "stok": stok,
    "deskripsi": deskripsi,
    "tanggal_verivikasi": tanggalVerivikasi.toIso8601String(),
    "status": status,
  };
}
