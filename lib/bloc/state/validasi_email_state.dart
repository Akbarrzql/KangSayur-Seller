import 'package:flutter/cupertino.dart';

import '../../model/validasi_email_model.dart';

@immutable
abstract class ValidasiEmailState{}

class ValidasiEmailInitial extends ValidasiEmailState {
  final ValidasiEmailModel validasiEmailModel;

  ValidasiEmailInitial({required this.validasiEmailModel});
}

class ValidasiEmailLoading extends ValidasiEmailState {}

class ValidasiEmailSuccess extends ValidasiEmailState {
  final ValidasiEmailModel validasiEmailModel;

  ValidasiEmailSuccess({required this.validasiEmailModel});
}

class ValidasiEmailError extends ValidasiEmailState {
  final String errorMessage;

  ValidasiEmailError({required this.errorMessage});
}