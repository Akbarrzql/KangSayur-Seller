import 'package:flutter/cupertino.dart';
import '../../model/list_promo_model.dart';

@immutable
abstract class ListPromoState {}

class ListPromoInitial extends ListPromoState {}

class ListPromoLoading extends ListPromoState {}

class ListPromoSuccess extends ListPromoState {
  final ListPromoModel listPromoModel;

  ListPromoSuccess(this.listPromoModel);
}

class ListPromoFailure extends ListPromoState {
  final String errorMessage;

  ListPromoFailure(this.errorMessage);
}