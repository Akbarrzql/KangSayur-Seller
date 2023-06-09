import 'package:flutter/cupertino.dart';
import '../../model/user_model.dart';

@immutable
abstract class ProfilePageState {}

class InitialProfilePageState extends ProfilePageState {}

class ProfilePageLoading extends ProfilePageState {}

class ProfilePageLoaded extends ProfilePageState {
  final UserModel userModel;

  ProfilePageLoaded(this.userModel);
}

class ProfilePageError extends ProfilePageState {
  final String errorMessage;

  ProfilePageError(this.errorMessage);
}
