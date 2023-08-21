import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kangsayur_seller/bloc/event/room_chat_event.dart';
import 'package:kangsayur_seller/bloc/state/room_chat_state.dart';

import '../../repository/room_chat_repository.dart';
import '../../repository/send_massage_repository.dart';

class RoomChatPageBloc extends Bloc<RoomChatEvent, RoomChatState>{
  final RoomChatPageRepository roomChatPageRepository;
  final SendMassagePageRepository sendMassagePageRepository;

  RoomChatPageBloc({required this.roomChatPageRepository, required this.sendMassagePageRepository}) : super(RoomChatInitial()){
    on<GetRoomChat>((event, emit) async{
      emit(RoomChatLoading());
      try{
        var roomChatModel = await roomChatPageRepository.GetRoomChat(event.conversationId);
        emit(RoomChatLoaded(roomChatModel));
      }catch(e){
        emit(RoomChatError(e.toString()));
      }
    });

    on<SendMassage>((event, emit) async{
      emit(RoomChatLoading());
      try{
        var sendMassageModel = await sendMassagePageRepository.SendMassage(event.conversationId, event.message);
        emit(SendMassageLoaded(sendMassageModel));
      }catch(e){
        emit(RoomChatError(e.toString()));
      }
    });
  }
}