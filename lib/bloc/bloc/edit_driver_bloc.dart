import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kangsayur_seller/bloc/event/edit_driver_event.dart';
import 'package:kangsayur_seller/bloc/state/edit_driver_state.dart';
import 'package:kangsayur_seller/bloc/state/edit_seller_state.dart';

import '../../repository/edit_driver_repository.dart';

class EditDriverPageBloc extends Bloc<EditDriverEvent, EditDriverState>{
  final EditDriverPageRepository editDriverPageRepository;

  EditDriverPageBloc({required this.editDriverPageRepository}) : super(EditDriverInitial()){
    on<EditDriver>((event, emit) async{
      emit(EditDriverLoading());
      try{
        var data = await editDriverPageRepository.editDriver(event.driverId, event.nama, event.foto, event.noHp, event.noPolisi, event.namaKendaraan);
        emit(EditDriverSuccess(data));
      }catch(e){
        emit(EditDriverError(e.toString()));
      }
    });
  }
}