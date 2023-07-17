import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kangsayur_seller/bloc/event/confirm_driver_event.dart';
import 'package:kangsayur_seller/bloc/state/confirm_driver_state.dart';

import '../../repository/menunggu_driver_repository.dart';

class ConfirmDriverPageBloc extends Bloc<ConfirmDriverPageEvent, ConfirmDriverPageState>{
  final MenungguDriverPageRepository confirmDriverPageRepository;

  ConfirmDriverPageBloc({required this.confirmDriverPageRepository}) : super(InitialConfirmDriverPageState()) {
    on<GetConfirmDriver>((event, emit) async {
      emit(ConfirmDriverPageLoading());
      try {
        emit(ConfirmDriverPageLoaded(
            await confirmDriverPageRepository.menunggu()));
      } catch (e) {
        emit(ConfirmDriverPageError(e.toString()));
      }
    });
  }
}