import 'package:flutter/cupertino.dart';

import '../../model/balas_ulasan_model.dart';
import '../../model/ulasan_seller_model.dart';

@immutable
abstract class UlasanSellerPageState {}

class InitialUlasanSellerPageState extends UlasanSellerPageState {}

class UlasanSellerPageLoading extends UlasanSellerPageState {}

class UlasanSellerPageLoaded extends UlasanSellerPageState {
  final UlasanSellerModel ulasanSellerModel;

  UlasanSellerPageLoaded(this.ulasanSellerModel);
}

class BalasUlasanPageLoaded extends UlasanSellerPageState{
  final BalasUlasanSellerModel balasUlasanSellerModel;

  BalasUlasanPageLoaded(this.balasUlasanSellerModel);
}

class UlasanSellerPageError extends UlasanSellerPageState {
  final String errorMessage;

  UlasanSellerPageError(this.errorMessage);
}