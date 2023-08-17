import 'package:flutter/cupertino.dart';

import '../../model/ubah_pw_driver_model.dart';

@immutable
abstract class UbahPwDriverState{}

class UbahPwDriverInitial extends UbahPwDriverState {}

class UbahPwDriverLoading extends UbahPwDriverState {}

class UbahPwDriverSuccess extends UbahPwDriverState {
  final UbahPasswordDriverModel ubahPasswordDriverModel;

  UbahPwDriverSuccess({required this.ubahPasswordDriverModel});
}

class UbahPwDriverError extends UbahPwDriverState {
  final String errorMessage;

  UbahPwDriverError({required this.errorMessage});
}