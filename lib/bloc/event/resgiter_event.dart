import 'dart:io';
import 'package:flutter/cupertino.dart';

@immutable
abstract class RegisterDriverEvent{}

class RegisterDriverButtonPressed extends RegisterDriverEvent {
  final String namaLengkap;
  final String email;
  final String noHp;
  final String noHpDarurat;
  final String password;
// final String konfirmasiPassword,
  final String jenisKendaraan;
  final String namaKendaraan;
  final String platNomor;
  final String noRangka;
  final File? photoDriver;
  final File? photoKTP;
  final File? photoSTNK;
  final File? photoKendaraan;

  RegisterDriverButtonPressed({
    required this.namaLengkap,
    required this.email,
    required this.noHp,
    required this.noHpDarurat,
    required this.password,
    // required this.konfirmasiPassword,
    required this.jenisKendaraan,
    required this.namaKendaraan,
    required this.platNomor,
    required this.noRangka,
    required this.photoDriver,
    required this.photoKTP,
    required this.photoSTNK,
    required this.photoKendaraan,
  });
}
