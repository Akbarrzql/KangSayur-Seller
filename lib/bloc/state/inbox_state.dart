import 'package:flutter/cupertino.dart';

import '../../model/inbox_model.dart';

@immutable
abstract class InboxState{}

class InitialInboxState extends InboxState {}

class InboxLoading extends InboxState {}

class InboxLoaded extends InboxState {
  final InboxModel inboxModel;

  InboxLoaded({required this.inboxModel});

}

class InboxError extends InboxState {
  final String message;

  InboxError({required this.message});

}