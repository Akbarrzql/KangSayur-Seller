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
  int id;
  String namaToko;
  String namaProduk;
  int hargaProduk;
  String alamat;
  dynamic imgId;
  String deskripsi;
  int stokProduk;

  Datum({
    required this.id,
    required this.namaToko,
    required this.namaProduk,
    required this.hargaProduk,
    required this.alamat,
    required this.imgId,
    required this.deskripsi,
    required this.stokProduk,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    namaToko: json["nama_toko"],
    namaProduk: json["nama_produk"],
    hargaProduk: json["harga_produk"],
    alamat: json["alamat"],
    imgId: json["img_id"],
    deskripsi: json["deskripsi"],
    stokProduk: json["stok_produk"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "nama_toko": namaToko,
    "nama_produk": namaProduk,
    "harga_produk": hargaProduk,
    "alamat": alamat,
    "img_id": imgId,
    "deskripsi": deskripsi,
    "stok_produk": stokProduk,
  };
}
