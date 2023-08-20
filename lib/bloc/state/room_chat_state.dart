import 'package:flutter/cupertino.dart';

import '../../model/room_chat_model.dart';

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