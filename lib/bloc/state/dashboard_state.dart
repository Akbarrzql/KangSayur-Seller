import 'package:flutter/cupertino.dart';

import '../../model/analisa_model.dart';
import '../../model/grafik_model.dart';
import '../../model/pemasukan_model.dart';
import '../../ui/bottom_navigation/item/dashboard.dart';

@immutable
abstract class DashboardPageState {}

class InitialDashboardPageState extends DashboardPageState {}

class DashboardPageLoading extends DashboardPageState {}

class DashboardPageLoaded extends DashboardPageState {
  final PemasukanModel pemasukanModel;
  final AnalisaModel analisaModel;
  final GrafikModel grafikModel;

  DashboardPageLoaded(this.pemasukanModel, this.analisaModel, this.grafikModel);
}

class DashboardPageError extends DashboardPageState {
  final String errorMessage;

  DashboardPageError(this.errorMessage);
}
