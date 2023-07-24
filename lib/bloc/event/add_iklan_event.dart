import 'dart:io';
import 'package:flutter/cupertino.dart';

@immutable
abstract class AddIklanEvent {}

class PostIklan extends AddIklanEvent {
  final File imgPamflet;
  final int kategoriId;

  PostIklan({
    required this.imgPamflet,
    required this.kategoriId,
});
}