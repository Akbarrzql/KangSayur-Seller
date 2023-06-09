import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kangsayur_seller/bloc/event/produk_event.dart';
import 'package:kangsayur_seller/bloc/state/produk_state.dart';
import 'package:kangsayur_seller/model/produk_model.dart';
import '../../repository/produk_repository.dart';

class ProdukPageBloc extends Bloc<ProdukPageEvent, ProdukPageState> {
  final ProdukPageRepository produkPageRepository;
  List<Datum> _filteredProdukModel = [];
  ProdukModel? _produkModel;

  ProdukPageBloc({required this.produkPageRepository})
      : super(InitialProdukPageState()) {
    on<GetProduk>((event, emit) async {
      emit(ProdukPageLoading());
      try {
        var produkModel = await produkPageRepository.produk();
        _produkModel = produkModel;
        emit(ProdukPageLoaded(produkModel));
      } catch (e) {
        emit(ProdukPageError(e.toString()));
      }
    });

    on<FilterProduk>((event, emit) {
      final keyword = event.keyword.toLowerCase();

      if (_produkModel != null) {
        if (keyword.isNotEmpty) {
          _filteredProdukModel = _produkModel!.data.where((produk) {
            final namaProduk = produk.namaProduk.toString().toLowerCase();
            return namaProduk.contains(keyword);
          }).toList();
        } else {
          _filteredProdukModel = _produkModel!.data;
        }
        emit(ProdukPageFiltered(_filteredProdukModel));
      }
    });
  }
}
