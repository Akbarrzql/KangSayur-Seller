import 'package:flutter/cupertino.dart';

import '../../model/produk_model.dart';

@immutable
abstract class ProdukPageState {}

class InitialProdukPageState extends ProdukPageState {}

class ProdukPageLoading extends ProdukPageState {}

class ProdukPageLoaded extends ProdukPageState {
  final ProdukModel produkModel;

  ProdukPageLoaded(this.produkModel);
}

class ProdukPageError extends ProdukPageState {
  final String errorMessage;

  ProdukPageError(this.errorMessage);
}

class ProdukPageFiltered extends ProdukPageState {
  final List<Datum> filteredProdukModel;

  ProdukPageFiltered(this.filteredProdukModel);
}


