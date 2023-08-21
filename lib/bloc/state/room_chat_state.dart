import 'package:flutter/cupertino.dart';

import '../../model/room_chat_model.dart';
import '../../model/send_massage_model.dart';

@immutable
abstract class RoomChatState {}

class RoomChatInitial extends RoomChatState {}

class RoomChatLoading extends RoomChatState {}

class RoomChatError extends RoomChatState {
  final String errorMessage;

  RoomChatError(this.errorMessage);
}

class RoomChatLoaded extends RoomChatState {
  final RoomChatModelModel roomChatModelModel;

  RoomChatLoaded(this.roomChatModelModel);
}

class SendMassageLoaded extends RoomChatState {
  final SendMassageModel sendMassageModel;

  SendMassageLoaded(this.sendMassageModel);
}