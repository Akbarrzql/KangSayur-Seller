import 'package:flutter/cupertino.dart';

@immutable
abstract class DashboardPageEvent {}

class GetData extends DashboardPageEvent {
  final String custom;

  GetData({required this.custom});
}
