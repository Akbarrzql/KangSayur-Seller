import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kangsayur_seller/constants/app_constants.dart';
import 'package:provider/provider.dart';
import 'package:kangsayur_seller/bloc/auth/login_bloc.dart';
import 'package:kangsayur_seller/repository/auth/login_repository.dart';

class LoginProvider extends StatelessWidget {
  final Widget child;

  LoginProvider({required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<LoginRepository>(
          create: (_) => LoginRepository(baseUrl: AppConstants.baseUrlAuth),
        ),
        BlocProvider<LoginBloc>(
          create: (context) => LoginBloc(loginRepository: context.read<LoginRepository>()),
        ),
      ],
      child: child,
    );
  }
}
