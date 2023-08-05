import 'package:flutter/cupertino.dart';

@immutable
abstract class UlasanSellerPageEvent {}

class GetUlasanSeller extends UlasanSellerPageEvent {}

class PutReplyUser extends UlasanSellerPageEvent {
  String productId;
  String variantId;
  String transactionCode;
  String reply;
  String idUser;

  PutReplyUser(this.productId, this.variantId, this.transactionCode, this.reply, this.idUser);
}
