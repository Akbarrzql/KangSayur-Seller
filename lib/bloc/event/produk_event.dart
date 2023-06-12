import 'package:flutter/cupertino.dart';

@immutable
abstract class ProdukPageEvent {}

class GetProduk extends ProdukPageEvent {}

class FilterProduk extends ProdukPageEvent {
  final String keyword;

  FilterProduk(this.keyword);
}
