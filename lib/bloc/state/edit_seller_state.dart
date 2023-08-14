import 'package:flutter/cupertino.dart';

import '../../model/edit_seller_model.dart';

@immutable
abstract class EditSellerState{}

class EditSellerInitial extends EditSellerState {}

class EditSellerLoading extends EditSellerState {}

class EditSellerSuccess extends EditSellerState {
  final EditSellerModel editSellerModel;

  EditSellerSuccess({required this.editSellerModel});
}

class EditSellerError extends EditSellerState {
  final String errorMessage;

  EditSellerError({required this.errorMessage});
}