import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kangsayur_seller/bloc/event/verifikasi_event.dart';
import 'package:kangsayur_seller/bloc/state/verifikasi_state.dart';

import '../../repository/verifikasi_repository.dart';

class VerifikasiBloc extends Bloc<VerifikasiPageEvent, VerifikasiPageState> {
  final VerifikasiPageRepository verifikasiPageRepository;

  VerifikasiBloc({required this.verifikasiPageRepository}) : super(InitialVerifikasiPageState()) {
    on<GetVerifikasi>((event, emit) async {
      emit(VerifikasiPageLoading());
      try {
        var verifikasiModel = await verifikasiPageRepository.verifikasi();
        emit(VerifikasiPageLoaded(verifikasiModel));
      } catch (e) {
        emit(VerifikasiPageError(e.toString()));
      }
    });
  }
}