import 'package:flutter/cupertino.dart';
import '../../model/disiapkan_model.dart';
import '../../model/konfirmasi_model.dart';
import '../../model/pesanan_model.dart';

@immutable
abstract class PesananPageState {}

class InitialPesananPageState extends PesananPageState {}

class PesananPageLoading extends PesananPageState {}

class PesananPageLoaded extends PesananPageState {
  final PesananModel pesananModel;

  PesananPageLoaded(this.pesananModel);
}

class KonfirmasiPageLoaded extends PesananPageState {
  final KonfirmasiModel konfirmasiModel;

  KonfirmasiPageLoaded(this.konfirmasiModel);
}

class PesananPageError extends PesananPageState {
  final String errorMessage;

  PesananPageError(this.errorMessage);
}
