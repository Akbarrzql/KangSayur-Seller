import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kangsayur_seller/bloc/event/ubah_pw_driver_event.dart';
import 'package:kangsayur_seller/bloc/state/ubah_pw_driver_state.dart';

import '../../repository/ubah_pw_driver_repository.dart';

class UbahPwDriverPageBloc extends Bloc<UbahPwDriverEvent, UbahPwDriverState>{
  final UbahPwDriverPageRepository ubahPwDriverPageRepository;

  UbahPwDriverPageBloc({required this.ubahPwDriverPageRepository}) : super(UbahPwDriverInitial()){
    on<UbahPwDriverEvent>((event, emit) async {
      if(event is UbahPwDriver){
        emit(UbahPwDriverLoading());
        try{
          final ubahPasswordDriverModel = await ubahPwDriverPageRepository.ubahPwDriver(event.driverId, event.password);
          emit(UbahPwDriverSuccess(ubahPasswordDriverModel: ubahPasswordDriverModel));
        }catch(e){
          emit(UbahPwDriverError(errorMessage: e.toString()));
        }
      }
    });
  }
}