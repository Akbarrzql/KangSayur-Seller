// To parse this JSON data, do
//
//     final kategoriModel = kategoriModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

KategoriModel kategoriModelFromJson(String str) => KategoriModel.fromJson(json.decode(str));

String kategoriModelToJson(KategoriModel data) => json.encode(data.toJson());

class KategoriModel {
  final String status;
  final String message;
  final List<Kategori> kategori;

  KategoriModel({
    required this.status,
    required this.message,
    required this.kategori,
  });

  factory KategoriModel.fromJson(Map<String, dynamic> json) => KategoriModel(
    status: json["status"],
    message: json["message"],
    kategori: List<Kategori>.from(json["kategori"].map((x) => Kategori.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "kategori": List<dynamic>.from(kategori.map((x) => x.toJson())),
  };
}

class Kategori {
  final int id;
  final String namaKategori;

  Kategori({
    required this.id,
    required this.namaKategori,
  });

  factory Kategori.fromJson(Map<String, dynamic> json) => Kategori(
    id: json["id"],
    namaKategori: json["nama_kategori"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "nama_kategori": namaKategori,
  };
}
