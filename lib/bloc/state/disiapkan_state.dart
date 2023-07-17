import 'package:flutter/cupertino.dart';

import '../../model/disiapkan_model.dart';
import '../../model/konfirmasi_model.dart';

@immutable
abstract class DisiapkanPageState {}

class InitialDisiapkanPageState extends DisiapkanPageState {}

class DisiapkanPageLoading extends DisiapkanPageState {}

class DisiapkanPageLoaded extends DisiapkanPageState {
  final DisiapkanModel disiapkanModel;

  DisiapkanPageLoaded(this.disiapkanModel);
}

class SiapAntarPageLoaded extends DisiapkanPageState {
  final KonfirmasiModel konfirmasiModel;

  SiapAntarPageLoaded(this.konfirmasiModel);
}

class DisiapkanPageError extends DisiapkanPageState {
  final String errorMessage;

  DisiapkanPageError(this.errorMessage);
}