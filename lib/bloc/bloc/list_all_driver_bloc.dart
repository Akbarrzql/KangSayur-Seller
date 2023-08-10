import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kangsayur_seller/bloc/event/list_all_driver_event.dart';
import 'package:kangsayur_seller/bloc/state/list_all_driver_state.dart';

import '../../repository/list_all_driver_repository.dart';

class ListAllDriverPageBloc extends Bloc<ListAllDriverEvent, ListAllDriverState>{
  final ListAllDriverPageRepository listAllDriverPageRepository;

  ListAllDriverPageBloc({required this.listAllDriverPageRepository}) : super(ListAllDriverInitial()) {
    on<GetListAllDriver>((event, emit) async {
      emit(ListAllDriverLoading());
      try {
        emit(ListAllDriverLoaded(await listAllDriverPageRepository.listAllDriver()));
      } catch (e) {
        emit(ListAllDriverError(e.toString()));
      }
    });
  }

}