import 'package:flutter/cupertino.dart';

import '../../model/edit_driver_model.dart';

@immutable
abstract class EditDriverState{}

class EditDriverInitial extends EditDriverState {}

class EditDriverLoading extends EditDriverState {}

class EditDriverSuccess extends EditDriverState {
  final EditDriverModel editDriverModel;

  EditDriverSuccess(this.editDriverModel);
}

class EditDriverError extends EditDriverState {
  final String errorMessage;

  EditDriverError(this.errorMessage);
}