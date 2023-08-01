import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kangsayur_seller/bloc/event/confirm_driver_event.dart';
import 'package:kangsayur_seller/bloc/event/selesai_event.dart';
import 'package:kangsayur_seller/bloc/state/confirm_driver_state.dart';
import 'package:kangsayur_seller/bloc/state/selesai_state.dart';
import 'package:kangsayur_seller/repository/selesai_repository.dart';


class SelesaiPageBloc extends Bloc<SelesaiPageEvent, SelesaiPageState>{
  final SelesaiRepository selesaiRepository;

  SelesaiPageBloc({required this.selesaiRepository}) : super(InitialSelesaiPageState()) {
    on<GetSelesai>((event, emit) async {
      emit(SelesaiPageLoading());
      try {
        emit(SelesaiPageLoaded(await selesaiRepository.selesai()));
      } catch (e) {
        emit(SelesaiPageError(e.toString()));
      }
    });
  }
}