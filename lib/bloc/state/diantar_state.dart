import 'package:flutter/cupertino.dart';
import '../../model/diantar_model.dart';

@immutable
abstract class DiantarPageState {}

class InitialDiantarPageState extends DiantarPageState {}

class DiantarPageLoading extends DiantarPageState {}

class DiantarPageLoaded extends DiantarPageState {
  final DiantarModel diantarModel;

  DiantarPageLoaded(this.diantarModel);
}

class DiantarPageError extends DiantarPageState {
  final String errorMessage;

  DiantarPageError(this.errorMessage);
}