import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kangsayur_seller/bloc/event/add_iklan_event.dart';
import 'package:kangsayur_seller/bloc/state/add_iklan_state.dart';
import 'package:kangsayur_seller/model/iklan_model.dart';
import 'package:kangsayur_seller/repository/iklan_repository.dart';

import '../../model/iklan_toko_model.dart';
import '../../repository/iklan_toko_repository.dart';

class IklanBloc extends Bloc<AddIklanEvent, AddIklanState>{
  final IklanRepository iklanRepository;
  final IklanTokoPageRepository iklanTokoPageRepository;
  IklanModel? _iklanModel;
  IklanTokoModel? _iklanTokoModel;

  IklanBloc({required this.iklanRepository, required this.iklanTokoPageRepository}) : super(InitialAddIklanState()){
    on<PostIklan>((event, emit) async{
      emit(AddIklanPageLoading());
      try{
        var iklanModel = await iklanRepository.postIklan(event.imgPamflet, event.kategoriId);
        _iklanModel = iklanModel;
        emit(AddIklanPageLoaded(iklanModel, ));
      }catch(e){
        emit(AddIklanPageError(e.toString()));
      }
    });

    on<PostIklanToko>((event, emit) async{
      emit(AddIklanPageLoading());
      try{
        var data = await iklanTokoPageRepository.postIklanToko(event.imgPamflet);
        emit(AddIklanPageLoaded(data));
      }catch(e){
        emit(AddIklanPageError(e.toString()));
      }
    });
  }
}