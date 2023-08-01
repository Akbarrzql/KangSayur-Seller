import 'package:flutter/cupertino.dart';
import 'package:kangsayur_seller/model/selesai_model.dart';

@immutable
abstract class SelesaiPageState {}

class InitialSelesaiPageState extends SelesaiPageState {}

class SelesaiPageLoading extends SelesaiPageState {}

class SelesaiPageLoaded extends SelesaiPageState {
  final SelesaiModel selesaiModel;

  SelesaiPageLoaded(this.selesaiModel);
}

class SelesaiPageError extends SelesaiPageState {
  final String errorMessage;

  SelesaiPageError(this.errorMessage);
}