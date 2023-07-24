import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kangsayur_seller/bloc/event/kategori_event.dart';
import 'package:kangsayur_seller/bloc/state/kategori_state.dart';

import '../../model/kategori_model.dart';
import '../../repository/kategori_repository.dart';

class KategoriBloc extends Bloc<KategoriEvent, KategoriState>{
  final KategoriRepository kategoriRepository;
  KategoriModel? _kategoriModel;

  KategoriBloc({required this.kategoriRepository}) : super(InitialKategoriState()){
    on<GetKategori>((event, emit) async{
      emit(KategoriPageLoading());
      try{
        var kategoriModel = await kategoriRepository.getKategori();
        _kategoriModel = kategoriModel;
        emit(KategoriPageLoaded(kategoriModel));
      }catch(e){
        emit(KategoriPageError(e.toString()));
      }
    });
  }

}
