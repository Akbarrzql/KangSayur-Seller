// To parse this JSON data, do
//
//     final listAllDriverModel = listAllDriverModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ListAllDriverModel listAllDriverModelFromJson(String str) => ListAllDriverModel.fromJson(json.decode(str));

String listAllDriverModelToJson(ListAllDriverModel data) => json.encode(data.toJson());

class ListAllDriverModel {
  final String status;
  final String message;
  final List<Produk> produk;

  ListAllDriverModel({
    required this.status,
    required this.message,
    required this.produk,
  });

  factory ListAllDriverModel.fromJson(Map<String, dynamic> json) => ListAllDriverModel(
    status: json["status"],
    message: json["message"],
    produk: List<Produk>.from(json["produk"].map((x) => Produk.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "produk": List<dynamic>.from(produk.map((x) => x.toJson())),
  };
}

class Produk {
  final String namaDriver;
  final int nomorTelfon;
  final String fotoDriver;
  final String namaKendaraan;
  final String nomorPolisi;

  Produk({
    required this.namaDriver,
    required this.nomorTelfon,
    required this.fotoDriver,
    required this.namaKendaraan,
    required this.nomorPolisi,
  });

  factory Produk.fromJson(Map<String, dynamic> json) => Produk(
    namaDriver: json["nama_driver"],
    nomorTelfon: json["nomor_telfon"],
    fotoDriver: json["foto_driver"],
    namaKendaraan: json["nama_kendaraan"],
    nomorPolisi: json["nomor_polisi"],
  );

  Map<String, dynamic> toJson() => {
    "nama_driver": namaDriver,
    "nomor_telfon": nomorTelfon,
    "foto_driver": fotoDriver,
    "nama_kendaraan": namaKendaraan,
    "nomor_polisi": nomorPolisi,
  };
}
