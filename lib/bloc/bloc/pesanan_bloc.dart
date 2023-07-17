import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kangsayur_seller/bloc/event/pesanan_event.dart';
import 'package:kangsayur_seller/bloc/state/pesanan_state.dart';
import 'package:kangsayur_seller/model/disiapkan_model.dart';
import 'package:kangsayur_seller/model/pesanan_model.dart';
import 'package:kangsayur_seller/repository/disiapkan_repository.dart';
import 'package:kangsayur_seller/repository/siap_antar_repository.dart';

import '../../model/konfirmasi_model.dart';
import '../../repository/konfirmasi_repository.dart';
import '../../repository/pesanan_repository.dart';
import '../event/disiapkan_event.dart';
import '../event/pesanan_event.dart';

class PesananPageBloc extends Bloc<PesananPageEvent, PesananPageState>{
  final PesananPageRepository pesananPageRepository;
  final KonfirmasiPageRepository konfirmasiPageRepository;
  PesananModel? _pesananModel;
  DisiapkanModel? _disiapkanModel;


  PesananPageBloc({required this.pesananPageRepository, required this.konfirmasiPageRepository}) : super(InitialPesananPageState()) {
    on<GetPesanan>((event, emit) async {
      emit(PesananPageLoading());
      try {
        _pesananModel = await pesananPageRepository.pesanan();
        emit(PesananPageLoaded(_pesananModel!));
      } catch (e) {
        emit(PesananPageError(e.toString()));
      }
    });

    on<GetKonfirmasi>((event, emit) async {
      emit(PesananPageLoading());
      try {
        emit(KonfirmasiPageLoaded(
            await konfirmasiPageRepository.konfirmasi(event.transactionCode)));
      } catch (e) {
        emit(PesananPageError(e.toString()));
      }
    });
  }
}