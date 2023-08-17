import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kangsayur_seller/bloc/state/list_promo_state.dart';

import '../../repository/list_promo_repository.dart';
import '../event/list_promo_event.dart';

class ListPromoPageBloc extends Bloc<ListPromoEvent,ListPromoState>{
  final ListPromoPageRepository listPromoPageRepository;

  ListPromoPageBloc({required this.listPromoPageRepository}) : super(ListPromoInitial()){
    on<GetListPromo>((event, emit) async{
      emit(ListPromoLoading());
      try{
        final listPromo = await listPromoPageRepository.listPromo();
        emit(ListPromoSuccess(listPromo));
      }catch(e){
        emit(ListPromoFailure(e.toString()));
      }
    });
  }
}