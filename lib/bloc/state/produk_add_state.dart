import 'package:flutter/cupertino.dart';
import 'package:kangsayur_seller/model/StatusCreateProdukModel.dart';
import '../../model/create_produk_model.dart';

@immutable
abstract class ProdukAddState {}

class InitialProdukAddState extends ProdukAddState {}

class ProdukAddLoading extends ProdukAddState {}

class ProdukAddLoaded extends ProdukAddState {
  final StatusCreateProdukModel statusCreateProdukModel;

  ProdukAddLoaded(this.statusCreateProdukModel);
}

class ProdukAddError extends ProdukAddState {
  final String errorMessage;

  ProdukAddError(this.errorMessage);
}