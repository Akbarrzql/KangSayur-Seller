import 'package:flutter/cupertino.dart';

@immutable

abstract class DisiapkanPageEvent {}

class GetDisiapkan extends DisiapkanPageEvent {}

class GetSiapAntar extends DisiapkanPageEvent {
  final String transactionCode;

  GetSiapAntar(this.transactionCode);
}

