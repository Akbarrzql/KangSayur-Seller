import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kangsayur_seller/bloc/event/validasi_email_event.dart';
import 'package:kangsayur_seller/bloc/state/validasi_email_state.dart';
import 'package:kangsayur_seller/repository/validasi_email_repository.dart';

import '../../model/validasi_email_model.dart';

class ValidasiEmailPageBloc extends Bloc<ValidasiEmailEvent,ValidasiEmailState>{
  final ValidasiEmailPageRepository validasiEmailPageRepository;

  ValidasiEmailPageBloc({required this.validasiEmailPageRepository}) : super(ValidasiEmailInitial(validasiEmailModel: ValidasiEmailModel(
    status: 0,
    message: '',
  ))){
    on<ValidasiEmail>((event, emit) async {
      emit(ValidasiEmailLoading());
      try {
        ValidasiEmailModel validasiEmailModel = await validasiEmailPageRepository.validasiEmail(event.email);
        emit(ValidasiEmailSuccess(validasiEmailModel: validasiEmailModel));
      } catch (e) {
        emit(ValidasiEmailError(errorMessage: e.toString()));
      }
    });
  }
}