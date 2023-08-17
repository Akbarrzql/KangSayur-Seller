import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kangsayur_seller/bloc/event/ubah_pw_seller_event.dart';
import 'package:kangsayur_seller/bloc/state/ubah_pw_seller_state.dart';

import '../../repository/ubah_pw_seller_repository.dart';

class UbahPwSellerPageBloc extends Bloc<UbahPwSellerEvent, UbahPwSellerState> {
  final UbahPwSellerPageRepository ubahPwSellerPageRepository;

  UbahPwSellerPageBloc({required this.ubahPwSellerPageRepository}) : super(UbahPwSellerInitial()){
    on<UbahPwSellerEvent>((event, emit) async {
      if(event is UbahPwSeller){
        emit(UbahPwSellerLoading());
        try{
          final ubahPasswordSellerModel = await ubahPwSellerPageRepository.ubahPwSeller(event.password);
          emit(UbahPwSellerSuccess(ubahPasswordSellerModel: ubahPasswordSellerModel));
        }catch(e){
          emit(UbahPwSellerError(errorMessage: e.toString()));
        }
      }
    });
  }
}