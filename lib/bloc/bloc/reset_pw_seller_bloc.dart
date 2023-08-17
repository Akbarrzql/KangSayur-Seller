import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repository/reset_pw_seller_repository.dart';
import '../event/reset_pw_seller_event.dart';
import '../state/reset_pw_seller_state.dart';

class ResetPasswordSellerPageBloc extends Bloc<ResetPwSellerEvent, ResetPwSellerState>{
  final ResetPwSellerPageRepository resetPasswordSellerPageRepository;

  ResetPasswordSellerPageBloc({required this.resetPasswordSellerPageRepository}) : super(ResetPwSellerInitial()){
on<ResetPwSellerEvent>((event, emit) async {
      if(event is ResetPwSeller){
        emit(ResetPwSellerLoading());
        try{
          final resetPasswordSellerModel = await resetPasswordSellerPageRepository.resetPwSeller();
          emit(ResetPwSellerSuccess(resetPasswordSellerModel: resetPasswordSellerModel));
        }catch(e){
          emit(ResetPwSellerError(errorMessage: e.toString()));
        }
      }
    });
  }
}