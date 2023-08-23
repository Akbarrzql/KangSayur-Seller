import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/list_chat_seller_model.dart';
import '../../model/start_convertation_model.dart';
import '../../repository/list_chat_repository.dart';
import '../../repository/start_convertation_repository.dart';
import '../event/list_chat_seller_event.dart';
import '../event/start_converatation_event.dart';
import '../state/start_converatation_state.dart';

class StartConvertationPageBloc extends Bloc<StartConversationEvent, StartConversationState>{
  final StartConveratationPageRepository startConvertationPageRepository;
  final ListChatSellerPageRepository listChatSellerPageRepository;

  StartConvertationPageBloc({required this.startConvertationPageRepository, required this.listChatSellerPageRepository}) : super(StartConversationInitial(
    StartConvertationModel(
      status: 0,
      convoId: 4
    ))){
    on<PostStartConversation>((event, emit) async {
      emit(StartConversationLoading());
      try {
        StartConvertationModel startConvertationModel = await startConvertationPageRepository.postStartConvertation(event.userId);
        ListChatSellerModel listChatSellerModel = await listChatSellerPageRepository.GetListChat();
        emit(StartConversationSuccess(startConvertationModel, listChatSellerModel));
      } catch (e) {
        emit(StartConversationError(e.toString()));
      }
    });
  }

}