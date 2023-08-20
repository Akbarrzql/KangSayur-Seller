import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kangsayur_seller/bloc/event/list_chat_seller_event.dart';
import 'package:kangsayur_seller/bloc/state/list_chat_seller_state.dart';

import '../../repository/list_chat_repository.dart';

class ListChatSellerPageBloc extends Bloc<ListChatSellerEvent, ListChatSellerState>{
  final ListChatSellerPageRepository listChatSellerPageRepository;

  ListChatSellerPageBloc({required this.listChatSellerPageRepository}) : super(ListChatSellerInitial()){
    on<GetListChatSeller>((event, emit) async{
      emit(ListChatSellerLoading());
      try{
        var listChatSellerModel = await listChatSellerPageRepository.GetListChat();
        emit(ListChatSellerLoaded(listChatSellerModel));
      }catch(e){
        emit(ListChatSellerError(e.toString()));
      }
    });
  }
}