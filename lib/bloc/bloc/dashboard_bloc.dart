import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kangsayur_seller/bloc/event/dashboard_event.dart';
import 'package:kangsayur_seller/bloc/state/dashboard_state.dart';
import 'package:kangsayur_seller/model/analisa_model.dart';

import '../../model/grafik_model.dart';
import '../../model/pemasukan_model.dart';
import '../../repository/analisa_repository.dart';
import '../../repository/grafik_repository.dart';
import '../../repository/pemasukan_repository.dart';

class DashboardPageBloc extends Bloc<DashboardPageEvent, DashboardPageState>{
  final PemasukanRepository pemasukanRepository;
  final AnalisaRepository analisaRepository;
  final GrafikRepository grafikRepository;

  DashboardPageBloc({required this.pemasukanRepository, required this.analisaRepository, required this.grafikRepository}) : super(InitialDashboardPageState()) {
    on<GetData>((event, emit) async {
      emit(DashboardPageLoading());
      try {
        PemasukanModel pemasukanModel = await pemasukanRepository.pemasukan(event.custom);
        AnalisaModel analisaModel = await analisaRepository.analisa(event.custom);
        GrafikModel grafikModel = await grafikRepository.grafik(event.custom);
        emit(DashboardPageLoaded(pemasukanModel, analisaModel, grafikModel));
      } catch (e) {
        emit(DashboardPageError(e.toString()));
      }
    });
  }
}


