// To parse this JSON data, do
//
//     final menungguDriverModel = menungguDriverModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

MenungguDriverModel menungguDriverModelFromJson(String str) => MenungguDriverModel.fromJson(json.decode(str));

String menungguDriverModelToJson(MenungguDriverModel data) => json.encode(data.toJson());

class MenungguDriverModel {
  final String status;
  final String message;
  final List<Datum> data;

  MenungguDriverModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory MenungguDriverModel.fromJson(Map<String, dynamic> json) => MenungguDriverModel(
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
  final String notes;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<StatusReadyDelivered> statusReadyDelivered;

  Datum({
    required this.id,
    required this.transactionCode,
    required this.userId,
    required this.paymentMethod,
    required this.transactionToken,
    required this.clientKey,
    required this.notes,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.statusReadyDelivered,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    transactionCode: json["transaction_code"],
    userId: json["user_id"],
    paymentMethod: json["payment_method"],
    transactionToken: json["transaction_token"],
    clientKey: json["client_key"],
    notes: json["notes"],
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    statusReadyDelivered: List<StatusReadyDelivered>.from(json["status_ready_delivered"].map((x) => StatusReadyDelivered.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "transaction_code": transactionCode,
    "user_id": userId,
    "payment_method": paymentMethod,
    "transaction_token": transactionToken,
    "client_key": clientKey,
    "notes": notes,
    "status": status,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "status_ready_delivered": List<dynamic>.from(statusReadyDelivered.map((x) => x.toJson())),
  };
}

class StatusReadyDelivered {
  final int id;
  final int transactionCode;
  final int productId;
  final int variantId;
  final int storeId;
  final int userId;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final dynamic variantImg;
  final String variant;
  final String variantDesc;
  final int stok;
  final int hargaVariant;

  StatusReadyDelivered({
    required this.id,
    required this.transactionCode,
    required this.productId,
    required this.variantId,
    required this.storeId,
    required this.userId,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.variantImg,
    required this.variant,
    required this.variantDesc,
    required this.stok,
    required this.hargaVariant,
  });

  factory StatusReadyDelivered.fromJson(Map<String, dynamic> json) => StatusReadyDelivered(
    id: json["id"],
    transactionCode: json["transaction_code"],
    productId: json["product_id"],
    variantId: json["variant_id"],
    storeId: json["store_id"],
    userId: json["user_id"],
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    variantImg: json["variant_img"],
    variant: json["variant"],
    variantDesc: json["variant_desc"],
    stok: json["stok"],
    hargaVariant: json["harga_variant"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "transaction_code": transactionCode,
    "product_id": productId,
    "variant_id": variantId,
    "store_id": storeId,
    "user_id": userId,
    "status": status,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "variant_img": variantImg,
    "variant": variant,
    "variant_desc": variantDesc,
    "stok": stok,
    "harga_variant": hargaVariant,
  };
}
