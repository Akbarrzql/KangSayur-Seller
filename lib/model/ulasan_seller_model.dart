// To parse this JSON data, do
//
//     final ulasanSellerModel = ulasanSellerModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

UlasanSellerModel ulasanSellerModelFromJson(String str) => UlasanSellerModel.fromJson(json.decode(str));

String ulasanSellerModelToJson(UlasanSellerModel data) => json.encode(data.toJson());

class UlasanSellerModel {
  final String status;
  final String message;
  final List<Datum> data;

  UlasanSellerModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory UlasanSellerModel.fromJson(Map<String, dynamic> json) => UlasanSellerModel(
    status: json["status"],
    message: json["message"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  final int produkId;
  final int userId;
  final String namaCustomer;
  final String namaProduk;
  final int variantId;
  final String gambarVariant;
  final String jenisVariant;
  final String statusDijawab;
  final String reviewUser;
  final DateTime tanggalPembelian;
  final DateTime tanggalReview;
  final int kodeTransaksi;
  final String namaToko;
  final String gambarToko;
  final String alamatToko;

  Datum({
    required this.produkId,
    required this.userId,
    required this.namaCustomer,
    required this.namaProduk,
    required this.variantId,
    required this.gambarVariant,
    required this.jenisVariant,
    required this.statusDijawab,
    required this.reviewUser,
    required this.tanggalPembelian,
    required this.tanggalReview,
    required this.kodeTransaksi,
    required this.namaToko,
    required this.gambarToko,
    required this.alamatToko,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    produkId: json["produk_id"],
    userId: json["user_id"],
    namaCustomer: json["nama_customer"],
    namaProduk: json["nama_produk"],
    variantId: json["variant_id"],
    gambarVariant: json["gambar_variant"],
    jenisVariant: json["jenis_variant"],
    statusDijawab: json["status_dijawab"],
    reviewUser: json["review_user"],
    tanggalPembelian: DateTime.parse(json["tanggal_pembelian"]),
    tanggalReview: DateTime.parse(json["tanggal_review"]),
    kodeTransaksi: json["kode_transaksi"],
    namaToko: json["nama_toko"],
    gambarToko: json["gambar_toko"],
    alamatToko: json["alamat_toko"],
  );

  Map<String, dynamic> toJson() => {
    "produk_id": produkId,
    "user_id": userId,
    "nama_customer": namaCustomer,
    "nama_produk": namaProduk,
    "variant_id": variantId,
    "gambar_variant": gambarVariant,
    "jenis_variant": jenisVariant,
    "status_dijawab": statusDijawab,
    "review_user": reviewUser,
    "tanggal_pembelian": tanggalPembelian.toIso8601String(),
    "tanggal_review": tanggalReview.toIso8601String(),
    "kode_transaksi": kodeTransaksi,
    "nama_toko": namaToko,
    "gambar_toko": gambarToko,
    "alamat_toko": alamatToko,
  };
}
