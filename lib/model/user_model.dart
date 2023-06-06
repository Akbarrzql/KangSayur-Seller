// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  int status;
  String message;
  Data data;

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
  int id;
  String namaToko;
  String? imgProfile;
  String name;
  String email;
  dynamic phoneNumber;

  Data({
    required this.id,
    required this.namaToko,
    required this.imgProfile,
    required this.name,
    required this.email,
    required this.phoneNumber,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    namaToko: json["nama_toko"],
    imgProfile: json["img_profile"],
    name: json["name"],
    email: json["email"],
    phoneNumber: json["phone_number"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "nama_toko": namaToko,
    "img_profile": imgProfile,
    "name": name,
    "email": email,
    "phone_number": phoneNumber,
  };
}
