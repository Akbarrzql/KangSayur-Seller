import 'package:flutter/cupertino.dart';

import '../../model/list_all_driver_model.dart';

@immutable
abstract class ListAllDriverState{}

class ListAllDriverInitial extends ListAllDriverState {}

class ListAllDriverLoading extends ListAllDriverState {}

class ListAllDriverLoaded extends ListAllDriverState {
  final ListAllDriverModel listAllDriverModel;

  ListAllDriverLoaded(this.listAllDriverModel);
}

class ListAllDriverError extends ListAllDriverState {
  final String errorMessage;

  ListAllDriverError(this.errorMessage);
}