import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kangsayur_seller/bloc/event/device_token_event.dart';
import 'package:kangsayur_seller/bloc/state/device_token_state.dart';
import 'package:kangsayur_seller/repository/device_token_repository.dart';

class DeviceTokenPageBloc extends Bloc<DeviceTokenEvent, DeviceTokenState>{
  final DeviceTokenPageRepository deviceTokenPageRepository;

  DeviceTokenPageBloc({required this.deviceTokenPageRepository}) : super(InitialDeviceTokenState()){
    on<SendDeviceToken>((event, emit) async {
      emit(DeviceTokenLoading());
      try {
        emit(DeviceTokenLoaded(await deviceTokenPageRepository.sendDeviceToken(event.email, event.password, event.deviceToken)));
      } catch (e) {
        emit(DeviceTokenError(e.toString()));
      }
    });
  }
}