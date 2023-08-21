import 'package:flutter/cupertino.dart';

@immutable
abstract class RoomChatEvent {}

class GetRoomChat extends RoomChatEvent {
  final String conversationId;

  GetRoomChat(this.conversationId);
}

class SendMassage extends RoomChatEvent {
  final String conversationId;
  final String message;

  SendMassage(this.conversationId, this.message);
}