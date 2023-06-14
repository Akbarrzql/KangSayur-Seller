import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kangsayur_seller/bloc/event/produk_event.dart';
import 'package:kangsayur_seller/bloc/state/produk_state.dart';
import 'package:kangsayur_seller/model/StatusCreateProdukModel.dart';
import 'package:kangsayur_seller/model/create_produk_model.dart';

import '../../repository/create_produk_repository.dart';
import '../event/produk_add_event.dart';
import '../state/produk_add_state.dart';

class ProdukAddPageBloc extends Bloc<ProdukAddEvent, ProdukAddState>{
  late StatusCreateProdukModel statusCreateProdukModel;
  final CreateProdukRepository createProdukRepository;

  ProdukAddPageBloc({required this.createProdukRepository}) : super(InitialProdukAddState()){
    on<AddProdukButtonPressed>((event, emit) async {
      emit(ProdukAddLoading());
      try {
        statusCreateProdukModel = await createProdukRepository.createProduk(event.namaProduk, event.kategoriId, event.variant);
        emit(ProdukAddLoaded(statusCreateProdukModel));
      } catch (e) {
        emit(ProdukAddError(e.toString()));
      }
    });
  }
}