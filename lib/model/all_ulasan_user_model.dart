// To parse this JSON data, do
//
//     final allUlasanSellerModel = allUlasanSellerModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

AllUlasanSellerModel allUlasanSellerModelFromJson(String str) => AllUlasanSellerModel.fromJson(json.decode(str));

String allUlasanSellerModelToJson(AllUlasanSellerModel data) => json.encode(data.toJson());

class AllUlasanSellerModel {
  final String status;
  final String message;
  final List<Datum> data;

  AllUlasanSellerModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory AllUlasanSellerModel.fromJson(Map<String, dynamic> json) => AllUlasanSellerModel(
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
  final String namaCustomer;
  final String gambarUser;
  final int rating;
  final String namaProduk;
  final int variantId;
  final String gambarVariant;
  final String jenisVariant;
  final String reply;
  final String reviewUser;
  final String statusDijawab;
  final DateTime tanggalPembelian;
  final DateTime tanggalReview;
  final int kodeRansaksi;

  Datum({
    required this.produkId,
    required this.namaCustomer,
    required this.gambarUser,
    required this.rating,
    required this.namaProduk,
    required this.variantId,
    required this.gambarVariant,
    required this.jenisVariant,
    required this.reply,
    required this.reviewUser,
    required this.statusDijawab,
    required this.tanggalPembelian,
    required this.tanggalReview,
    required this.kodeRansaksi,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    produkId: json["produk_id"],
    namaCustomer: json["nama_customer"],
    gambarUser: json["gambar_user"],
    rating: json["rating"],
    namaProduk: json["nama_produk"],
    variantId: json["variant_id"],
    gambarVariant: json["gambar_variant"],
    jenisVariant: json["jenis_variant"],
    reply: json["reply"],
    reviewUser: json["review_user"],
    statusDijawab: json["status_dijawab"],
    tanggalPembelian: DateTime.parse(json["tanggal_pembelian"]),
    tanggalReview: DateTime.parse(json["tanggal_review"]),
    kodeRansaksi: json["kode_ransaksi"],
  );

  Map<String, dynamic> toJson() => {
    "produk_id": produkId,
    "nama_customer": namaCustomer,
    "gambar_user": gambarUser,
    "rating": rating,
    "nama_produk": namaProduk,
    "variant_id": variantId,
    "gambar_variant": gambarVariant,
    "jenis_variant": jenisVariant,
    "reply": reply,
    "review_user": reviewUser,
    "status_dijawab": statusDijawab,
    "tanggal_pembelian": tanggalPembelian.toIso8601String(),
    "tanggal_review": tanggalReview.toIso8601String(),
    "kode_ransaksi": kodeRansaksi,
  };
}
