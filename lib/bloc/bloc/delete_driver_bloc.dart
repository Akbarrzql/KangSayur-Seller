import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kangsayur_seller/bloc/event/delete_driver_event.dart';
import 'package:kangsayur_seller/bloc/state/delete_driver_state.dart';

import '../../repository/delete_driver_repository.dart';

class DeletDriverPageBloc extends Bloc<DeleteDriverEvent, DeleteDriverState>{
  final DeleteDriverPageRepository deleteDriverPageRepository;

  DeletDriverPageBloc({required this.deleteDriverPageRepository}) : super(DeleteDriverInitial()){
    on<DeleteDriver>((event, emit) async{
      emit(DeleteDriverLoading());
      try{
        var deleteDriverModel = await deleteDriverPageRepository.deleteDriver(event.driverId);
        emit(DeleteDriverLoaded(deleteDriverModel));
      }catch(e){
        emit(DeleteDriverError(e.toString()));
      }
    });
  }
}