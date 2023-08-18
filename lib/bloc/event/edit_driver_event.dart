import 'dart:io';
import 'package:flutter/cupertino.dart';

@immutable
abstract class EditDriverEvent{}

class EditDriver extends EditDriverEvent {
  final String driverId;
  final String nama;
  final File? foto;
  final String noHp;
  final String noPolisi;
  final String namaKendaraan;

  EditDriver(this.driverId, this.nama, this.foto, this.noHp, this.noPolisi, this.namaKendaraan);
}