import 'package:flutter/cupertino.dart';
import 'package:kangsayur_seller/model/menunggu_driver_model.dart';

@immutable
abstract class ConfirmDriverPageState {}

class InitialConfirmDriverPageState extends ConfirmDriverPageState {}

class ConfirmDriverPageLoading extends ConfirmDriverPageState {}

class ConfirmDriverPageLoaded extends ConfirmDriverPageState {
  final MenungguDriverModel confirmDriverModel;

  ConfirmDriverPageLoaded(this.confirmDriverModel);
}

class ConfirmDriverPageError extends ConfirmDriverPageState {
  final String errorMessage;

  ConfirmDriverPageError(this.errorMessage);
}