import 'dart:io';

import 'package:flutter/cupertino.dart';

@immutable
abstract class EditSellerEvent{}

class EditSeller extends EditSellerEvent {
  final String namaToko;
  final String deksripsiToko;
  final String alamatToko;
  final String openTime;
  final String closeTime;
  final File? imgHeader;
  final File? imgProfile;

  EditSeller({
    required this.namaToko,
    required this.deksripsiToko,
    required this.alamatToko,
    required this.openTime,
    required this.closeTime,
    required this.imgHeader,
    required this.imgProfile,
  });
}