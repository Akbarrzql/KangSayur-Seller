import 'package:flutter/cupertino.dart';

import '../../model/delete_driver_model.dart';

@immutable
abstract class DeleteDriverState{}

class DeleteDriverInitial extends DeleteDriverState {}

class DeleteDriverLoading extends DeleteDriverState {}

class DeleteDriverLoaded extends DeleteDriverState {
  final DeleteDriverModel deleteDriverModel;

  DeleteDriverLoaded(this.deleteDriverModel);
}

class DeleteDriverError extends DeleteDriverState {
  final String errorMessage;

  DeleteDriverError(this.errorMessage);
}