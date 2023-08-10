// To parse this JSON data, do
//
//     final updateDeviceTokenModel = updateDeviceTokenModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

UpdateDeviceTokenModel updateDeviceTokenModelFromJson(String str) => UpdateDeviceTokenModel.fromJson(json.decode(str));

String updateDeviceTokenModelToJson(UpdateDeviceTokenModel data) => json.encode(data.toJson());

class UpdateDeviceTokenModel {
  final Data data;

  UpdateDeviceTokenModel({
    required this.data,
  });

  factory UpdateDeviceTokenModel.fromJson(Map<String, dynamic> json) => UpdateDeviceTokenModel(
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data.toJson(),
  };
}

class Data {
  final int id;
  final String name;
  final String photo;
  final String email;
  final int phoneNumber;
  final String emailVerifiedAt;
  final int sandiId;
  final int jenisKelamin;
  final DateTime tanggalLahir;
  final String address;
  final double longitude;
  final double latitude;
  final String deviceToken;
  final DateTime createdAt;
  final DateTime updatedAt;

  Data({
    required this.id,
    required this.name,
    required this.photo,
    required this.email,
    required this.phoneNumber,
    required this.emailVerifiedAt,
    required this.sandiId,
    required this.jenisKelamin,
    required this.tanggalLahir,
    required this.address,
    required this.longitude,
    required this.latitude,
    required this.deviceToken,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    name: json["name"],
    photo: json["photo"],
    email: json["email"],
    phoneNumber: json["phone_number"],
    emailVerifiedAt: json["email_verified_at"],
    sandiId: json["sandi_id"],
    jenisKelamin: json["jenis_kelamin"],
    tanggalLahir: DateTime.parse(json["tanggal_lahir"]),
    address: json["address"],
    longitude: json["longitude"]?.toDouble(),
    latitude: json["latitude"]?.toDouble(),
    deviceToken: json["device_token"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "photo": photo,
    "email": email,
    "phone_number": phoneNumber,
    "email_verified_at": emailVerifiedAt,
    "sandi_id": sandiId,
    "jenis_kelamin": jenisKelamin,
    "tanggal_lahir": tanggalLahir.toIso8601String(),
    "address": address,
    "longitude": longitude,
    "latitude": latitude,
    "device_token": deviceToken,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
