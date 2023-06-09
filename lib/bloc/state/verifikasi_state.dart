import 'package:flutter/cupertino.dart';
import 'package:kangsayur_seller/model/verifikasi_model.dart';

@immutable
abstract class VerifikasiPageState {}

class InitialVerifikasiPageState extends VerifikasiPageState {}

class VerifikasiPageLoading extends VerifikasiPageState {}

class VerifikasiPageLoaded extends VerifikasiPageState {
  final VerifikasiModel verifikasiModel;

  VerifikasiPageLoaded(this.verifikasiModel);
}

class VerifikasiPageError extends VerifikasiPageState {
  final String errorMessage;

  VerifikasiPageError(this.errorMessage);
}

