import 'package:flutter/cupertino.dart';

import '../../model/reset_pw_seller_model.dart';

@immutable
abstract class ResetPwSellerState{}

class ResetPwSellerInitial extends ResetPwSellerState {}

class ResetPwSellerLoading extends ResetPwSellerState {}

class ResetPwSellerSuccess extends ResetPwSellerState {
  final ResetPasswordSellerModel resetPasswordSellerModel;

  ResetPwSellerSuccess({required this.resetPasswordSellerModel});
}

class ResetPwSellerError extends ResetPwSellerState {
  final String errorMessage;

  ResetPwSellerError({required this.errorMessage});
}