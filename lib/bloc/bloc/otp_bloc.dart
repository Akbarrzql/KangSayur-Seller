import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kangsayur_seller/bloc/event/otp_event.dart';
import 'package:kangsayur_seller/bloc/state/otp_state.dart';

import '../../repository/otp_repository.dart';

class OtpPageBloc extends Bloc<OtpEvent, OtpState>{
  final OtpPageRepository otpPageRepository;

  OtpPageBloc({required this.otpPageRepository}) : super(OtpInitial()){
    on<OtpEvent>((event, emit) async{
      if(event is OtpEventGetOtp){
        emit(OtpLoading());
        try{
          var otpModel = await otpPageRepository.getOtp(event.email);
          emit(OtpSuccess(otpModel));
        }catch(e){
          emit(OtpFailure(e.toString()));
        }
      }
    });
  }
}