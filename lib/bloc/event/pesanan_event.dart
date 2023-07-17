
import 'package:flutter/cupertino.dart';

@immutable
abstract class PesananPageEvent {}

class GetPesanan extends PesananPageEvent {}

class GetKonfirmasi extends PesananPageEvent {
  final String transactionCode;

  GetKonfirmasi(this.transactionCode);
}

