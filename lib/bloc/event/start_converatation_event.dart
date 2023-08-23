import 'package:flutter/cupertino.dart';

@immutable
abstract class StartConversationEvent{}

class PostStartConversation extends StartConversationEvent{
  final String userId;

  PostStartConversation({required this.userId});
}