import 'package:flutter/cupertino.dart';

@immutable
abstract class ValidasiEmailEvent{}

class ValidasiEmail extends ValidasiEmailEvent {
  final String email;

  ValidasiEmail({required this.email});
}