import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kangsayur_seller/bloc/event/ulasan_seller_event.dart';
import 'package:kangsayur_seller/bloc/state/ulasan_seller_state.dart';

import '../../repository/balasan_user_repository.dart';
import '../../repository/ulasan_seller_repository.dart';

class UlasanSellerPageBloc extends Bloc<UlasanSellerPageEvent, UlasanSellerPageState>{
  final UlasanSellerPageRepository ulasanSellerPageRepository;
  final BalasanUserSellerRepository balasanUserSellerRepository;

  UlasanSellerPageBloc({required this.ulasanSellerPageRepository, required this.balasanUserSellerRepository}) : super(InitialUlasanSellerPageState()) {
    on<GetUlasanSeller>((event, emit) async {
      emit(UlasanSellerPageLoading());
      try {
        emit(UlasanSellerPageLoaded(
            await ulasanSellerPageRepository.getUlasanSeller()));
      } catch (e) {
        emit(UlasanSellerPageError(e.toString()));
      }
    });

    on<PutReplyUser>((event, emit) async{
      emit(UlasanSellerPageLoading());
      try {
        emit(BalasUlasanPageLoaded(await balasanUserSellerRepository.balas(event.productId, event.variantId, event.transactionCode, event.reply, event.idUser)));
      } catch (e) {
        emit(UlasanSellerPageError(e.toString()));
      }
    });
  }
}