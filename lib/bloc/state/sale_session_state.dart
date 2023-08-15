import 'package:flutter/cupertino.dart';

import '../../model/sale_session_promo.dart';

@immutable
abstract class SaleSessionState {}

class SaleSessionInitial extends SaleSessionState {}

class SaleSessionLoading extends SaleSessionState {}

class SaleSessionLoaded extends SaleSessionState {
  final SaleSessionPromoModel saleSessionPromoModel;

  SaleSessionLoaded({required this.saleSessionPromoModel});
}

class SaleSessionError extends SaleSessionState {
  final String message;

  SaleSessionError({required this.message});
}