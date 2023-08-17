// To parse this JSON data, do
//
//     final listPromoModel = listPromoModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ListPromoModel listPromoModelFromJson(String str) => ListPromoModel.fromJson(json.decode(str));

String listPromoModelToJson(ListPromoModel data) => json.encode(data.toJson());

class ListPromoModel {
  final String status;
  final String message;
  final String title;
  final String start;
  final String end;
  final List<Datum> data;

  ListPromoModel({
    required this.status,
    required this.message,
    required this.title,
    required this.start,
    required this.end,
    required this.data,
  });

  factory ListPromoModel.fromJson(Map<String, dynamic> json) => ListPromoModel(
    status: json["status"],
    message: json["message"],
    title: json["title"],
    start: json["start"],
    end: json["end"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "title": title,
    "start": start,
    "end": end,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  final int produkId;
  final String namaProduk;
  final int tokoId;
  final String namaToko;
  final String gambarProduk;
  final int variantId;
  final int hargaAwal;
  final String variant;
  final int hargaSale;
  final int stok;
  final double diskon;

  Datum({
    required this.produkId,
    required this.namaProduk,
    required this.tokoId,
    required this.namaToko,
    required this.gambarProduk,
    required this.variantId,
    required this.hargaAwal,
    required this.variant,
    required this.hargaSale,
    required this.stok,
    required this.diskon,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    produkId: json["produk_id"],
    namaProduk: json["nama_produk"],
    tokoId: json["toko_id"],
    namaToko: json["nama_toko"],
    gambarProduk: json["gambar_produk"],
    variantId: json["variant_id"],
    hargaAwal: json["harga_awal"],
    variant: json["variant"],
    hargaSale: json["harga_sale"],
    stok: json["stok"],
    diskon: json["diskon"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "produk_id": produkId,
    "nama_produk": namaProduk,
    "toko_id": tokoId,
    "nama_toko": namaToko,
    "gambar_produk": gambarProduk,
    "variant_id": variantId,
    "harga_awal": hargaAwal,
    "variant": variant,
    "harga_sale": hargaSale,
    "stok": stok,
    "diskon": diskon,
  };
}
