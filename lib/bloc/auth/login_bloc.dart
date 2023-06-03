import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:kangsayur_seller/repository/auth/login_repository.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginRepository loginRepository;

  LoginBloc({required this.loginRepository}) : super(LoginInitial());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginButtonPressed) {
      yield LoginLoading();

      try {
        final token = await loginRepository.login(
          email: event.email,
          password: event.password,
        );
        yield LoginSuccess(token: token);
      } catch (error) {
        yield LoginFailure(error: error.toString());
      }
    }
  }
}
