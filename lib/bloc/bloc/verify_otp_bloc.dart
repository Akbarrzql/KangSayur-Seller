import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kangsayur_seller/bloc/event/verify_otp_event.dart';
import 'package:kangsayur_seller/bloc/state/verify_otp_state.dart';

import '../../repository/verify_otp_repository.dart';

class VerifyOtpPageBloc extends Bloc<VerifyOtpEvent, VerifyOtpState> {
   final VerifyOtpPageRepository verifyOtpPageRepository;

    VerifyOtpPageBloc({required this.verifyOtpPageRepository}) : super(VerifyOtpInitial()){
      on<VerifyOtpEvent>((event, emit) async {
        if (event is VerifyOtpEventVerifyOtp) {
          emit(VerifyOtpLoading());
          try {
            var data = await verifyOtpPageRepository.verifyOtp(event.email, event.otp);
            emit(VerifyOtpSuccess(data));
          } catch (e) {
            emit(VerifyOtpFailure(e.toString()));
          }
        }
      });
    }
}