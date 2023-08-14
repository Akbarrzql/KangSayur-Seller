import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kangsayur_seller/bloc/event/edit_seller_event.dart';
import 'package:kangsayur_seller/bloc/state/edit_seller_state.dart';
import 'package:kangsayur_seller/repository/edit_seller_repository.dart';

class EditSellerPageBloc extends Bloc<EditSellerEvent, EditSellerState>{
  final EditSellerPageRepository editSellerPageRepository;

  EditSellerPageBloc({required this.editSellerPageRepository}) : super(EditSellerInitial()){
    on<EditSeller>((event, emit) async {
      emit(EditSellerLoading());
      try{
        final editSeller = await editSellerPageRepository.editSeller(
          event.namaToko,
          event.deksripsiToko,
          event.alamatToko,
          event.openTime,
          event.closeTime,
          event.imgHeader,
          event.imgProfile,
        );
        emit(EditSellerSuccess(editSellerModel: editSeller));
      }catch(e){
        emit(EditSellerError(errorMessage: e.toString()));
      }
    });
  }
}