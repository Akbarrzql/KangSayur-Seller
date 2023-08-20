import 'package:flutter/cupertino.dart';

import '../../model/list_chat_seller_model.dart';

@immutable
abstract class ListChatSellerState {}

class ListChatSellerInitial extends ListChatSellerState {}

class ListChatSellerLoading extends ListChatSellerState {}

class ListChatSellerError extends ListChatSellerState {
  final String errorMessage;

  ListChatSellerError(this.errorMessage);
}

class ListChatSellerLoaded extends ListChatSellerState {
  final ListChatSellerModel listChatSellerModel;

  ListChatSellerLoaded(this.listChatSellerModel);
}