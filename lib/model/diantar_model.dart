// To parse this JSON data, do
//
//     final diantarModel = diantarModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

DiantarModel diantarModelFromJson(String str) => DiantarModel.fromJson(json.decode(str));

String diantarModelToJson(DiantarModel data) => json.encode(data.toJson());

class DiantarModel {
  final String status;
  final String message;
  final List<Datum> data;

  DiantarModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory DiantarModel.fromJson(Map<String, dynamic> json) => DiantarModel(
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
  final int id;
  final int transactionCode;
  final int userId;
  final String paymentMethod;
  final String transactionToken;
  final String clientKey;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<StatusDelivered> statusDelivered;

  Datum({
    required this.id,
    required this.transactionCode,
    required this.userId,
    required this.paymentMethod,
    required this.transactionToken,
    required this.clientKey,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.statusDelivered,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    transactionCode: json["transaction_code"],
    userId: json["user_id"],
    paymentMethod: json["payment_method"],
    transactionToken: json["transaction_token"],
    clientKey: json["client_key"],
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    statusDelivered: List<StatusDelivered>.from(json["status_delivered"].map((x) => StatusDelivered.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "transaction_code": transactionCode,
    "user_id": userId,
    "payment_method": paymentMethod,
    "transaction_token": transactionToken,
    "client_key": clientKey,
    "status": status,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "status_delivered": List<dynamic>.from(statusDelivered.map((x) => x.toJson())),
  };
}

class StatusDelivered {
  final int id;
  final int transactionCode;
  final int productId;
  final int variantId;
  final int storeId;
  final int userId;
  final String? notes;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String namaProduk;
  final String variantImg;
  final String variant;
  final String variantDesc;
  final int stok;
  final int hargaVariant;
  final int jumlahPembelian;

  StatusDelivered({
    required this.id,
    required this.transactionCode,
    required this.productId,
    required this.variantId,
    required this.storeId,
    required this.userId,
    required this.notes,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.namaProduk,
    required this.variantImg,
    required this.variant,
    required this.variantDesc,
    required this.stok,
    required this.hargaVariant,
    required this.jumlahPembelian,
  });

  factory StatusDelivered.fromJson(Map<String, dynamic> json) => StatusDelivered(
    id: json["id"],
    transactionCode: json["transaction_code"],
    productId: json["product_id"],
    variantId: json["variant_id"],
    storeId: json["store_id"],
    userId: json["user_id"],
    notes: json["notes"] ?? "",
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    namaProduk: json["nama_produk"],
    variantImg: json["variant_img"],
    variant: json["variant"],
    variantDesc: json["variant_desc"],
    stok: json["stok"],
    hargaVariant: json["harga_variant"],
    jumlahPembelian: json["jumlah_pembelian"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "transaction_code": transactionCode,
    "product_id": productId,
    "variant_id": variantId,
    "store_id": storeId,
    "user_id": userId,
    "notes": notes,
    "status": status,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "nama_produk": namaProduk,
    "variant_img": variantImg,
    "variant": variant,
    "variant_desc": variantDesc,
    "stok": stok,
    "harga_variant": hargaVariant,
    "jumlah_pembelian": jumlahPembelian,
  };
}
