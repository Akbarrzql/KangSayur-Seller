import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kangsayur_seller/bloc/event/add_iklan_event.dart';
import 'package:kangsayur_seller/bloc/state/add_iklan_state.dart';
import 'package:kangsayur_seller/model/iklan_model.dart';
import 'package:kangsayur_seller/repository/iklan_repository.dart';

class IklanBloc extends Bloc<AddIklanEvent, AddIklanState>{
  final IklanRepository iklanRepository;
  IklanModel? _iklanModel;

  IklanBloc({required this.iklanRepository}) : super(InitialAddIklanState()){
    on<PostIklan>((event, emit) async{
      emit(AddIklanPageLoading());
      try{
        var iklanModel = await iklanRepository.postIklan(event.imgPamflet, event.kategoriId);
        _iklanModel = iklanModel;
        emit(AddIklanPageLoaded(iklanModel));
      }catch(e){
        emit(AddIklanPageError(e.toString()));
      }
    });
  }
}