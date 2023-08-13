import 'package:flutter/cupertino.dart';

@immutable
abstract class DeleteDriverEvent{}

class DeleteDriver extends DeleteDriverEvent {
  final String driverId;

  DeleteDriver(this.driverId);
}