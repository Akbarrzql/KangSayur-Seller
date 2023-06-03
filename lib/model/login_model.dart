import 'package:meta/meta.dart';
import 'dart:convert';

class LoginModel {
  int status;
  String message;
  Data data;
  String accesToken;
  String tokenType;

  LoginModel({
    required this.status,
    required this.message,
    required this.data,
    required this.accesToken,
    required this.tokenType,
  });

  factory LoginModel.fromRawJson(String str) => LoginModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
    status: json["status"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
    accesToken: json["acces_token"],
    tokenType: json["token_type"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data.toJson(),
    "acces_token": accesToken,
    "token_type": tokenType,
  };
}

class Data {
  String name;
  dynamic photo;
  String email;
  dynamic phoneNumber;
  dynamic emailVerifiedAt;
  int jenisKelamin;
  DateTime tanggalLahir;
  dynamic address;
  String linkFoto;

  Data({
    required this.name,
    required this.photo,
    required this.email,
    required this.phoneNumber,
    required this.emailVerifiedAt,
    required this.jenisKelamin,
    required this.tanggalLahir,
    required this.address,
    required this.linkFoto,
  });

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    name: json["name"],
    photo: json["photo"],
    email: json["email"],
    phoneNumber: json["phone_number"],
    emailVerifiedAt: json["email_verified_at"],
    jenisKelamin: json["jenis_kelamin"],
    tanggalLahir: DateTime.parse(json["tanggal_lahir"]),
    address: json["address"],
    linkFoto: json["link_foto"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "photo": photo,
    "email": email,
    "phone_number": phoneNumber,
    "email_verified_at": emailVerifiedAt,
    "jenis_kelamin": jenisKelamin,
    "tanggal_lahir": tanggalLahir.toIso8601String(),
    "address": address,
    "link_foto": linkFoto,
  };
}
