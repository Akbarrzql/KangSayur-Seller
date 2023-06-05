// To parse this JSON data, do
//
//     final registerModel = registerModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

RegisterModel registerModelFromJson(String str) => RegisterModel.fromJson(json.decode(str));

String registerModelToJson(RegisterModel data) => json.encode(data.toJson());

class RegisterModel {
  int status;
  Data data;
  String accesToken;

  RegisterModel({
    required this.status,
    required this.data,
    required this.accesToken,
  });

  factory RegisterModel.fromJson(Map<String, dynamic> json) => RegisterModel(
    status: json["status"],
    data: Data.fromJson(json["data"]),
    accesToken: json["acces_token"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data.toJson(),
    "acces_token": accesToken,
  };
}

class Data {
  String name;
  String email;
  int? sandiId;
  String? phoneNumber;
  String address;
  String longitude;
  String latitude;
  int? id;

  Data({
    required this.name,
    required this.email,
    required this.sandiId,
    required this.phoneNumber,
    required this.address,
    required this.longitude,
    required this.latitude,
    required this.id,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    name: json["name"],
    email: json["email"],
    sandiId: json["sandi_id"],
    phoneNumber: json["phone_number"],
    address: json["address"],
    longitude: json["longitude"],
    latitude: json["latitude"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "email": email,
    "sandi_id": sandiId,
    "phone_number": phoneNumber,
    "address": address,
    "longitude": longitude,
    "latitude": latitude,
    "id": id,
  };
}
