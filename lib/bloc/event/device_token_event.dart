import 'package:flutter/cupertino.dart';

@immutable
abstract class DeviceTokenEvent {}

class SendDeviceToken extends DeviceTokenEvent {
  final String email;
  final String password;
  final String deviceToken;

  SendDeviceToken({required this.email, required this.password, required this.deviceToken});
}