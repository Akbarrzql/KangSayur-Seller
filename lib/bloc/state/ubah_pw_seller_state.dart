import 'package:flutter/cupertino.dart';

import '../../model/ubah_password_seller_model.dart';

@immutable
abstract class UbahPwSellerState{}

class UbahPwSellerInitial extends UbahPwSellerState {}

class UbahPwSellerLoading extends UbahPwSellerState {}

class UbahPwSellerSuccess extends UbahPwSellerState {
  final UbahPasswordSellerModel ubahPasswordSellerModel;

  UbahPwSellerSuccess({required this.ubahPasswordSellerModel});
}

class UbahPwSellerError extends UbahPwSellerState {
  final String errorMessage;

  UbahPwSellerError({required this.errorMessage});
}