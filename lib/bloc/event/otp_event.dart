import 'package:flutter/cupertino.dart';

@immutable
abstract class OtpEvent {}

class OtpEventGetOtp extends OtpEvent {
  final String email;

  OtpEventGetOtp(this.email);
}