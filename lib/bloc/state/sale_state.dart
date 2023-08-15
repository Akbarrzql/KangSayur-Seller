import 'package:flutter/cupertino.dart';
import '../../model/sale_model.dart';

@immutable
abstract class SaleState {}

class SaleInitial extends SaleState {}

class SaleLoading extends SaleState {}

class SaleLoaded extends SaleState {
  final SaleModel saleModel;

  SaleLoaded({required this.saleModel});
}

class SaleError extends SaleState {
  final String message;

  SaleError({required this.message});
}