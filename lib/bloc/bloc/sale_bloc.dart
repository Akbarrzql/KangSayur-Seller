import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kangsayur_seller/bloc/event/sale_event.dart';
import 'package:kangsayur_seller/bloc/state/sale_state.dart';
import 'package:kangsayur_seller/repository/sale_repository.dart';

class SalePagBloc extends Bloc<SaleEvent, SaleState>{
  final SalePageRepository salePageRepository;

  SalePagBloc({required this.salePageRepository}) : super(SaleInitial()){
    on<SalePost>((event, emit) async {
      emit(SaleLoading());
      try {
        var saleModel = await salePageRepository.postSale(
          event.sessionId,
          event.produkId,
          event.varianId,
          event.hargaSale,
          event.stokSale,
        );
        emit(SaleLoaded(saleModel: saleModel));
      } catch (e) {
        emit(SaleError(message: e.toString()));
      }
    });
  }
}