import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kangsayur_seller/bloc/event/room_chat_event.dart';
import 'package:kangsayur_seller/bloc/state/room_chat_state.dart';

import '../../repository/room_chat_repository.dart';

class RoomChatPageBloc extends Bloc<RoomChatEvent, RoomChatState>{
  final RoomChatPageRepository roomChatPageRepository;

  RoomChatPageBloc({required this.roomChatPageRepository}) : super(RoomChatInitial()){
    on<GetRoomChat>((event, emit) async{
      emit(RoomChatLoading());
      try{
        var roomChatModel = await roomChatPageRepository.GetRoomChat(event.conversationId);
        emit(RoomChatLoaded(roomChatModel));
      }catch(e){
        emit(RoomChatError(e.toString()));
      }
    });
  }
}