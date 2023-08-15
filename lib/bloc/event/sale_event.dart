import 'package:flutter/cupertino.dart';

@immutable
abstract class SaleEvent {}

class SalePost extends SaleEvent {
  final String sessionId;
  final String produkId;
  final String varianId;
  final String hargaSale;
  final String stokSale;

  SalePost({
    required this.sessionId,
    required this.produkId,
    required this.varianId,
    required this.hargaSale,
    required this.stokSale,
  });
}