// To parse this JSON data, do
//
//     final analisaModel = analisaModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

AnalisaModel analisaModelFromJson(String str) => AnalisaModel.fromJson(json.decode(str));

String analisaModelToJson(AnalisaModel data) => json.encode(data.toJson());

class AnalisaModel {
  int status;
  Data data;

  AnalisaModel({
    required this.status,
    required this.data,
  });

  factory AnalisaModel.fromJson(Map<String, dynamic> json) => AnalisaModel(
    status: json["status"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data.toJson(),
  };
}

class Data {
  int pesanan;
  int pengunjungToko;
  double ratingProduk;
  int produkTerjual;
  int laporan;
  int ratingPelayanan;

  Data({
    required this.pesanan,
    required this.pengunjungToko,
    required this.ratingProduk,
    required this.produkTerjual,
    required this.laporan,
    required this.ratingPelayanan,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    pesanan: json["pesanan"],
    pengunjungToko: json["pengunjung_toko"],
    ratingProduk: json["rating_produk"]?.toDouble(),
    produkTerjual: json["produk_terjual"],
    laporan: json["laporan"],
    ratingPelayanan: json["rating_pelayanan"],
  );

  Map<String, dynamic> toJson() => {
    "pesanan": pesanan,
    "pengunjung_toko": pengunjungToko,
    "rating_produk": ratingProduk,
    "produk_terjual": produkTerjual,
    "laporan": laporan,
    "rating_pelayanan": ratingPelayanan,
  };
}
