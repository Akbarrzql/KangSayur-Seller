import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kangsayur_seller/repository/sale_session_promo.dart';

import '../event/sale_session_promo.dart';
import '../state/sale_session_state.dart';

class SaleSessionPageBloc extends Bloc<SaleSessionEvent, SaleSessionState>{
  final SaleSessionPromoPageRepository saleSessionPagePromoRepository;

  SaleSessionPageBloc({required this.saleSessionPagePromoRepository}) : super(SaleSessionInitial()){
    on<SaleSessionGet>((event, emit) async {
      emit(SaleSessionLoading());
      try {
        var saleSessionPromoModel = await saleSessionPagePromoRepository.GetSessionPromo();
        emit(SaleSessionLoaded(saleSessionPromoModel: saleSessionPromoModel));
      } catch (e) {
        emit(SaleSessionError(message: e.toString()));
      }
    });
  }
}