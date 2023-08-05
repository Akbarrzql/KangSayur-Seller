// To parse this JSON data, do
//
//     final resgisterDriverModel = resgisterDriverModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ResgisterDriverModel resgisterDriverModelFromJson(String str) => ResgisterDriverModel.fromJson(json.decode(str));

String resgisterDriverModelToJson(ResgisterDriverModel data) => json.encode(data.toJson());

class ResgisterDriverModel {
  final int status;
  final DataUser dataUser;
  final DataKendaraan dataKendaraan;
  final String accesToken;
  final Sandi sandi;

  ResgisterDriverModel({
    required this.status,
    required this.dataUser,
    required this.dataKendaraan,
    required this.accesToken,
    required this.sandi,
  });

  factory ResgisterDriverModel.fromJson(Map<String, dynamic> json) => ResgisterDriverModel(
    status: json["status"],
    dataUser: DataUser.fromJson(json["data_user"]),
    dataKendaraan: DataKendaraan.fromJson(json["data_kendaraan"]),
    accesToken: json["acces_token"],
    sandi: Sandi.fromJson(json["sandi"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data_user": dataUser.toJson(),
    "data_kendaraan": dataKendaraan.toJson(),
    "acces_token": accesToken,
    "sandi": sandi.toJson(),
  };
}

class DataKendaraan {
  final int driverId;
  final int tokoId;
  final String noTelfonCadangan;
  final String jenisKendaraan;
  final String nomorPolisi;
  final String nomorRangka;
  final String photoKtp;
  final String photoKk;
  final String photoKendaraan;
  final DateTime updatedAt;
  final DateTime createdAt;
  final int id;

  DataKendaraan({
    required this.driverId,
    required this.tokoId,
    required this.noTelfonCadangan,
    required this.jenisKendaraan,
    required this.nomorPolisi,
    required this.nomorRangka,
    required this.photoKtp,
    required this.photoKk,
    required this.photoKendaraan,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
  });

  factory DataKendaraan.fromJson(Map<String, dynamic> json) => DataKendaraan(
    driverId: json["driver_id"],
    tokoId: json["toko_id"],
    noTelfonCadangan: json["noTelfon_cadangan"],
    jenisKendaraan: json["jenis_kendaraan"],
    nomorPolisi: json["nomor_polisi"],
    nomorRangka: json["nomor_rangka"],
    photoKtp: json["photo_ktp"],
    photoKk: json["photo_kk"],
    photoKendaraan: json["photo_kendaraan"],
    updatedAt: DateTime.parse(json["updated_at"]),
    createdAt: DateTime.parse(json["created_at"]),
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "driver_id": driverId,
    "toko_id": tokoId,
    "noTelfon_cadangan": noTelfonCadangan,
    "jenis_kendaraan": jenisKendaraan,
    "nomor_polisi": nomorPolisi,
    "nomor_rangka": nomorRangka,
    "photo_ktp": photoKtp,
    "photo_kk": photoKk,
    "photo_kendaraan": photoKendaraan,
    "updated_at": updatedAt.toIso8601String(),
    "created_at": createdAt.toIso8601String(),
    "id": id,
  };
}

class DataUser {
  final String name;
  final String photo;
  final String phoneNumber;
  final String email;
  final int sandiId;
  final int id;

  DataUser({
    required this.name,
    required this.photo,
    required this.phoneNumber,
    required this.email,
    required this.sandiId,
    required this.id,
  });

  factory DataUser.fromJson(Map<String, dynamic> json) => DataUser(
    name: json["name"],
    photo: json["photo"],
    phoneNumber: json["phone_number"],
    email: json["email"],
    sandiId: json["sandi_id"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "photo": photo,
    "phone_number": phoneNumber,
    "email": email,
    "sandi_id": sandiId,
    "id": id,
  };
}

class Sandi {
  final int id;
  final String password;
  final DateTime updatedAt;
  final DateTime createdAt;

  Sandi({
    required this.id,
    required this.password,
    required this.updatedAt,
    required this.createdAt,
  });

  factory Sandi.fromJson(Map<String, dynamic> json) => Sandi(
    id: json["id"],
    password: json["password"],
    updatedAt: DateTime.parse(json["updated_at"]),
    createdAt: DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "password": password,
    "updated_at": updatedAt.toIso8601String(),
    "created_at": createdAt.toIso8601String(),
  };
}
