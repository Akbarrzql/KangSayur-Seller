import 'package:flutter/cupertino.dart';

import '../../model/kategori_model.dart';

@immutable
abstract class KategoriState {}

class InitialKategoriState extends KategoriState {}

class KategoriPageLoading extends KategoriState {}

class KategoriPageLoaded extends KategoriState {
  final KategoriModel kategoriModel;

  KategoriPageLoaded(this.kategoriModel);
}

class KategoriPageError extends KategoriState {
  final String errorMessage;

  KategoriPageError(this.errorMessage);
}