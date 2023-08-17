import 'package:flutter/cupertino.dart';

@immutable
abstract class VerifyOtpEvent {}

class VerifyOtpEventVerifyOtp extends VerifyOtpEvent {
  final String email;
  final String otp;

  VerifyOtpEventVerifyOtp(this.email, this.otp);
}
