import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kangsayur_seller/bloc/event/resgiter_event.dart';
import 'package:kangsayur_seller/bloc/state/resgister_driver_state.dart';

import '../../repository/register_driver_repository.dart';

class RegisterDriverPageBloc extends Bloc<RegisterDriverEvent, RegisterDriverState>{
  final RegisterDriverRepository registerDriverRepository;

  RegisterDriverPageBloc({required this.registerDriverRepository}) : super(InitialRegisterDriverState()){
    on<RegisterDriverButtonPressed>((event, emit) async {
      emit(RegisterDriverLoading());
      try {
        var registerDriverModel = await registerDriverRepository.registerDriver(
          event.namaLengkap,
          event.email,
          event.noHp,
          event.noHpDarurat,
          event.password,
          // event.konfirmasiPassword,
          event.jenisKendaraan,
          // event.namaKendaraan,
          event.platNomor,
          event.noRangka,
          event.photoDriver,
          event.photoKTP,
          event.photoSTNK,
          event.photoKendaraan,
        );
        emit(RegisterDriverSuccess(registerDriverModel));
      } catch (e) {
        emit(RegisterDriverError(e.toString()));
      }
    });
  }

}