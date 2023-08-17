import 'package:flutter/cupertino.dart';

@immutable
abstract class UbahPwDriverEvent{}

class UbahPwDriver extends UbahPwDriverEvent {
  final String driverId;
  final String password;

  UbahPwDriver({required this.driverId, required this.password});
}