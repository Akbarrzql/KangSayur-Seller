// To parse this JSON data, do
//
//     final createProdukModel = createProdukModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

CreateProdukModel createProdukModelFromJson(String str) => CreateProdukModel.fromJson(json.decode(str));

String createProdukModelToJson(CreateProdukModel data) => json.encode(data.toJson());

class CreateProdukModel {
  String namaProduk;
  int kategoriId;
  List<Variant> variant;

  CreateProdukModel({
    required this.namaProduk,
    required this.kategoriId,
    required this.variant,
  });

  factory CreateProdukModel.fromJson(Map<String, dynamic> json) => CreateProdukModel(
    namaProduk: json["nama_produk"],
    kategoriId: json["kategori_id"],
    variant: List<Variant>.from(json["variant"].map((x) => Variant.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "nama_produk": namaProduk,
    "kategori_id": kategoriId,
    "variant": List<dynamic>.from(variant.map((x) => x.toJson())),
  };
}

class Variant {
  String variant;
  String variantDesc;
  int stok;
  int hargaVariant;

  Variant({
    required this.variant,
    required this.variantDesc,
    required this.stok,
    required this.hargaVariant,
  });

  factory Variant.fromJson(Map<String, dynamic> json) => Variant(
    variant: json["variant"],
    variantDesc: json["variant_desc"],
    stok: json["stok"],
    hargaVariant: json["harga_variant"],
  );

  Map<String, dynamic> toJson() => {
    "variant": variant,
    "variant_desc": variantDesc,
    "stok": stok,
    "harga_variant": hargaVariant,
  };
}
