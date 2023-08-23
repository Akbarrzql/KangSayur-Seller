import 'package:flutter/cupertino.dart';

import '../../model/list_chat_seller_model.dart';
import '../../model/start_convertation_model.dart';

@immutable
abstract class StartConversationState{}

class StartConversationInitial extends StartConversationState{
  final StartConvertationModel startConversationModel;

  StartConversationInitial(this.startConversationModel);
}

class StartConversationLoading extends StartConversationState{}

class StartConversationSuccess extends StartConversationState{
  final StartConvertationModel startConversationModel;
  final ListChatSellerModel listChatSellerModel;

  StartConversationSuccess(this.startConversationModel, this.listChatSellerModel);
}

class StartConversationError extends StartConversationState{
  final String errorMessage;

  StartConversationError(this.errorMessage);
}