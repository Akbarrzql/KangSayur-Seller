import 'package:flutter/cupertino.dart';

import '../../model/device_token_model.dart';

@immutable
abstract class DeviceTokenState {}

class InitialDeviceTokenState extends DeviceTokenState {}

class DeviceTokenLoading extends DeviceTokenState {}

class DeviceTokenLoaded extends DeviceTokenState {
  final UpdateDeviceTokenModel updateDeviceTokenModel;

  DeviceTokenLoaded(this.updateDeviceTokenModel);
}

class DeviceTokenError extends DeviceTokenState {
  final String errorMessage;

  DeviceTokenError(this.errorMessage);
}