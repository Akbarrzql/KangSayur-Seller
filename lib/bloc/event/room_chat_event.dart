import 'package:flutter/cupertino.dart';

@immutable
abstract class RoomChatEvent {}

class GetRoomChat extends RoomChatEvent {
  final String conversationId;

  GetRoomChat(this.conversationId);
}