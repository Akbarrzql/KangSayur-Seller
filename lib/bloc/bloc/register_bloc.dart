import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kangsayur_seller/bloc/event/register_event.dart';
import 'package:kangsayur_seller/bloc/state/register_state.dart';
import 'package:kangsayur_seller/model/register_model.dart';

import '../../repository/register_repository.dart';

class RegisterPageBloc extends Bloc<RegisterPageEvent, RegisterPageState>{
  late RegisterModel registerModel;
  final RegisterRepository registerRepository;

  RegisterPageBloc({required this.registerRepository}) : super(InitialRegisterPageState()){
    on<RegisterButtonPressed>((event, emit) async {
      emit(RegisterPageLoading());
      try {
        registerModel = await registerRepository.register(
          event.email,
          event.password,
          event.ownerName,
          event.phoneNumber,
          event.ownerAddress,
          event.storeName,
          event.description,
          event.storeAddress,
          event.storeLongitude,
          event.storeLatitude,
          event.open,
          event.close,
          event.photo,
        );
        emit(RegisterPageLoaded(registerModel));
      } catch (e) {
        emit(RegisterPageError(e.toString()));
      }
    });
  }
}