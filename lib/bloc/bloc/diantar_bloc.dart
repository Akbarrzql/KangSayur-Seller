import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kangsayur_seller/bloc/state/diantar_state.dart';

import '../../repository/dianatar_repository.dart';
import '../event/diantar_event.dart';

class DiantarPageBloc extends Bloc<DiantarPageEvent, DiantarPageState>{
  final DiantarPageRepository diantarPageRepository;

  DiantarPageBloc({required this.diantarPageRepository}) : super(InitialDiantarPageState()) {
    on<GetDiantar>((event, emit) async {
      emit(DiantarPageLoading());
      try {
        emit(DiantarPageLoaded(await diantarPageRepository.diantar()));
      } catch (e) {
        emit(DiantarPageError(e.toString()));
      }
    });
  }
}