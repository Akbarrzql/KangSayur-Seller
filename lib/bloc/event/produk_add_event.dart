import 'package:flutter/cupertino.dart';

import '../../model/create_produk_model.dart';

@immutable
abstract class ProdukAddEvent {}

class AddProdukButtonPressed extends ProdukAddEvent {
  final String namaProduk;
  final int kategoriId;
  final List<Map<String, dynamic>> variant;


  AddProdukButtonPressed({required this.namaProduk, required this.kategoriId, required this.variant});
}