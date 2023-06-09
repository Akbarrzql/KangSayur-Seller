import 'dart:io';
import 'package:flutter/cupertino.dart';

@immutable
abstract class RegisterPageEvent {}

class RegisterButtonPressed extends RegisterPageEvent {
  final String email;
  final String password;
  final String ownerName;
  final String phoneNumber;
  final String ownerAddress;
  final String storeName;
  final String description;
  final String storeAddress;
  final String storeLongitude;
  final String storeLatitude;
  final String open;
  final String close;
  final File? photo;

  RegisterButtonPressed({
    required this.email,
    required this.password,
    required this.ownerName,
    required this.phoneNumber,
    required this.ownerAddress,
    required this.storeName,
    required this.description,
    required this.storeAddress,
    required this.storeLongitude,
    required this.storeLatitude,
    required this.open,
    required this.close,
    required this.photo,
  });
}