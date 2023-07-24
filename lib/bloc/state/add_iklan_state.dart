import 'package:flutter/cupertino.dart';

import '../../model/iklan_model.dart';

@immutable
abstract class AddIklanState {}

class InitialAddIklanState extends AddIklanState {}

class AddIklanPageLoading extends AddIklanState {}

class AddIklanPageLoaded extends AddIklanState {
  final IklanModel iklanModel;

  AddIklanPageLoaded(this.iklanModel);
}

class AddIklanPageError extends AddIklanState {
  final String errorMessage;

  AddIklanPageError(this.errorMessage);
}