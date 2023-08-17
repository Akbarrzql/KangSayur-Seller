import 'package:flutter/cupertino.dart';

@immutable
abstract class UbahPwSellerEvent {}

class UbahPwSeller extends UbahPwSellerEvent {
  final String password;

  UbahPwSeller({required this.password});
}