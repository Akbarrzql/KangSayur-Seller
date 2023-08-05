import 'package:flutter/cupertino.dart';

import '../../model/register_driver_model.dart';

@immutable
abstract class RegisterDriverState{}

class InitialRegisterDriverState extends RegisterDriverState{}

class RegisterDriverLoading extends RegisterDriverState{}

class RegisterDriverSuccess extends RegisterDriverState{
  final ResgisterDriverModel registerDriverModel;

  RegisterDriverSuccess(this.registerDriverModel);
}

class RegisterDriverError extends RegisterDriverState{
  final String errorMessage;

  RegisterDriverError(this.errorMessage);
}