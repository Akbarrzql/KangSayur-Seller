// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  final int status;
  final String message;
  final Data data;

  UserModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    status: json["status"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data.toJson(),
  };
}

class Data {
  final int id;
  final String namaToko;
  final String imgProfile;
  final String alamat;
  final String open;
  final String close;
  final String name;
  final String email;
  final int phoneNumber;
  final String address;

  Data({
    required this.id,
    required this.namaToko,
    required this.imgProfile,
    required this.alamat,
    required this.open,
    required this.close,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.address,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    namaToko: json["nama_toko"],
    imgProfile: json["img_profile"],
    alamat: json["alamat"],
    open: json["open"],
    close: json["close"],
    name: json["name"],
    email: json["email"],
    phoneNumber: json["phone_number"],
    address: json["address"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "nama_toko": namaToko,
    "img_profile": imgProfile,
    "alamat": alamat,
    "open": open,
    "close": close,
    "name": name,
    "email": email,
    "phone_number": phoneNumber,
    "address": address,
  };
}
