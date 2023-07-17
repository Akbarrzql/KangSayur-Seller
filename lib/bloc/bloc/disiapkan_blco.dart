import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kangsayur_seller/bloc/event/disiapkan_event.dart';
import 'package:kangsayur_seller/bloc/state/disiapkan_state.dart';

import '../../repository/disiapkan_repository.dart';
import '../../repository/siap_antar_repository.dart';

class DisiapkanPageBloc extends Bloc<DisiapkanPageEvent, DisiapkanPageState>{
  final DisiapkanPageRepository disiapkanPageRepository;
  final SiapAntarPageRepository siapAntarPageRepository;

  DisiapkanPageBloc({required this.disiapkanPageRepository, required this.siapAntarPageRepository}) : super(InitialDisiapkanPageState()) {
    on<GetDisiapkan>((event, emit) async {
      emit(DisiapkanPageLoading());
      try {
        emit(DisiapkanPageLoaded(
            await disiapkanPageRepository.disiapkan()));
      } catch (e) {
        emit(DisiapkanPageError(e.toString()));
      }
    });

    on<GetSiapAntar>((event, emit) async {
      emit(DisiapkanPageLoading());
      try {
        emit(SiapAntarPageLoaded(
            await siapAntarPageRepository.siapAntar(event.transactionCode)));
      } catch (e) {
        emit(DisiapkanPageError(e.toString()));
      }
    });
  }
}