import 'package:flutter/cupertino.dart';

@immutable
abstract class InboxEvent {}

class GetInbox extends InboxEvent {}