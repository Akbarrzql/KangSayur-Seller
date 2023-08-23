import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kangsayur_seller/bloc/bloc/login_bloc.dart';
import 'package:kangsayur_seller/bloc/state/login_state.dart';
import 'package:kangsayur_seller/common/color_value.dart';
import 'package:kangsayur_seller/ui/widget/custom_textfield.dart';
import 'package:kangsayur_seller/validator/input_validator.dart';
import '../../../bloc/bloc/validasi_email_bloc.dart';
import '../../../bloc/event/login_event.dart';
import '../../../bloc/event/validasi_email_event.dart';
import '../../../bloc/state/validasi_email_state.dart';
import '../../../repository/login_repository.dart';
import '../../../repository/validasi_email_repository.dart';
import '../../bottom_navigation/bottom_navigation.dart';

import '../password/send_email.dart';

class login_screen extends StatefulWidget {
  const login_screen({Key? key}) : super(key: key);

  @override
  State<login_screen> createState() => _login_screenState();
}

class _login_screenState extends State<login_screen> {

  bool isPasswordVisible = true;
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _emailHasError = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginPageBloc(loginRepository: LoginRepository()),
      child: Scaffold(
        body: BlocConsumer<LoginPageBloc, LoginPageState>(
          listener: (context, state) {},
          builder: (context, state){
            if(state is InitialLoginPageState){
              return buildInitalLayout(context);
            }else if(state is LoginPageLoading){
              return const Center(child: CircularProgressIndicator());
            }else if(state is LoginPageLoaded){
              return buildLoadedLayout();
            }else if(state is LoginPageError){
              return const Center(child: Text('Error'),);
            }else{
              return buildInitalLayout(context);
            }
          },
        )
      ),
    );
  }

  Widget buildInitalLayout(BuildContext context) => SafeArea(
    child: Padding(
      padding: const EdgeInsets.all(24),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(
              height: 24,
            ),
            Text(
              'Masuk',
              style: Theme.of(context).textTheme.headline5!.copyWith(
                fontWeight: FontWeight.bold,
                color: ColorValue.secondaryColor,
              ),
              textAlign: TextAlign.start,
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              width: 200,
              child: Text(
                "Selamat datang kembali! Anda telah dirindukan",
                style: Theme.of(context).textTheme.subtitle1!.copyWith(
                  fontWeight: FontWeight.w800,
                  color: const Color(0xff1E1E1E),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            BlocProvider(
              create: (context) => ValidasiEmailPageBloc(validasiEmailPageRepository: ValidasiEmailRepository()),
              child: BlocConsumer<ValidasiEmailPageBloc, ValidasiEmailState>(
                listener: (context, state) {},
                builder: (context, state) {
                  if (state is ValidasiEmailInitial){
                    return CustomTextFormField(
                      controller: _emailController,
                      label: 'Masukkan Email',
                      textInputType: TextInputType.emailAddress,
                      validator: (value) {
                        if (state.validasiEmailModel.status == 0) {
                          return InputValidator.emailValidator(value);
                        }else if (state.validasiEmailModel.message == "email dapat didaftarkan") {
                          return 'Email belum terdaftar';
                        }else{
                          return InputValidator.emailValidator(value);
                        }
                      },
                      onChanged: (p0) {
                        if (p0!.length > 5) {
                          context.read<ValidasiEmailPageBloc>().add(ValidasiEmail(email: p0));
                        }
                        return null;
                      },
                    );
                  }else if (state is ValidasiEmailLoading) {
                    return CustomTextFormField(
                      controller: _emailController,
                      label: 'Masukkan Email',
                      textInputType: TextInputType.emailAddress,
                      validator: (value) => InputValidator.emailValidator(value),
                      onChanged: (p0) {
                        if (p0!.length > 5) {
                          context.read<ValidasiEmailPageBloc>().add(ValidasiEmail(email: p0));
                        }
                        return null;
                      },
                    );
                  }else if (state is ValidasiEmailSuccess) {
                    return CustomTextFormField(
                      controller: _emailController,
                      label: 'Masukkan Email',
                      textInputType: TextInputType.emailAddress,
                      validator: (value) {
                        //kondisi email belum terdaftar
                        if (state.validasiEmailModel.status == 0) {
                          return InputValidator.emailValidator(value);
                        }else if (state.validasiEmailModel.message == "email dapat didaftarkan") {
                          return 'Email belum terdaftar';
                        }else{
                          return InputValidator.emailValidator(value);
                        }
                      },
                      onChanged: (p0) {
                        if (p0!.length > 5) {
                          context.read<ValidasiEmailPageBloc>().add(ValidasiEmail(email: p0));
                        }
                        return null;
                      },
                    );
                  }
                  else if (state is ValidasiEmailError) {
                    return CustomTextFormField(
                      controller: _emailController,
                      label: 'Masukkan Email',
                      textInputType: TextInputType.emailAddress,
                      validator: (value) => InputValidator.emailValidator(value),
                      onChanged: (p0) {
                        if (p0!.length > 5) {
                          context.read<ValidasiEmailPageBloc>().add(ValidasiEmail(email: p0));
                        }
                        return null;
                      },
                    );
                  }else{
                    return CustomTextFormField(
                      controller: _emailController,
                      label: 'Masukkan Email',
                      textInputType: TextInputType.emailAddress,
                      validator: (value) => InputValidator.emailValidator(value),
                      onChanged: (p0) {
                        if (p0!.length > 5) {
                          context.read<ValidasiEmailPageBloc>().add(ValidasiEmail(email: p0));
                        }
                        return null;
                      },
                    );
                  }
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            CustomTextFormField(
              controller: _passwordController,
              label: 'Password',
              isPassword: true,
              textInputType: TextInputType.visiblePassword,
              validator: (value) => InputValidator.passwordValidator(value),
            ),
            const SizedBox(
              height: 2,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  if(_emailController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        backgroundColor: Colors.red,
                        margin: EdgeInsets.fromLTRB(24, 0, 24, 80),
                        behavior: SnackBarBehavior.floating,
                        content: Text('Email tidak boleh kosong dan harus diisi terlebih dahulu'),
                      ),
                    );
                  }else{
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SendEmailPage(
                      email: _emailController.text,
                    )));
                  }
                },
                child: Text(
                  'Lupa Password?',
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    color: ColorValue.secondaryColor,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
            const Spacer(),
            SizedBox(
              child: ElevatedButton(
                onPressed: () async{
                  if(_formKey.currentState!.validate()){
                    // String? deviceToken = await FirebaseNotificationManager.getToken();
                    // print('Device Token: $deviceToken');

                    BlocProvider.of<LoginPageBloc>(context).add(LoginButtonPressed(
                      email: _emailController.text,
                      password: _passwordController.text,
                    ));

                    // if(deviceToken != null){
                    //   BlocProvider(
                    //     create: (context) => DeviceTokenPageBloc(deviceTokenPageRepository: DeviceTokenRepository())..add(SendDeviceToken(
                    //       email: _emailController.text,
                    //       password: _passwordController.text,
                    //       deviceToken: deviceToken,
                    //     )),
                    //   );
                    //   BlocProvider.of<LoginPageBloc>(context).add(LoginButtonPressed(
                    //     email: _emailController.text,
                    //     password: _passwordController.text,
                    //   ));
                    // }
                  }else{
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        backgroundColor: Colors.red,
                        margin: EdgeInsets.fromLTRB(24, 0, 24, 80),
                        behavior: SnackBarBehavior.floating,
                        content: Text('Terdapat kesalahan pada inputan'),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  primary: ColorValue.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: Text(
                  'Masuk',
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );

  Widget buildLoadedLayout() => Center(
    child: Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Selamat Datang',
            style: Theme.of(context).textTheme.headline5!.copyWith(
              fontWeight: FontWeight.bold,
              color: ColorValue.secondaryColor,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 30,
          ),
          Text(
            'Anda telah berhasil masuk',
            style: Theme.of(context).textTheme.subtitle1!.copyWith(
              fontWeight: FontWeight.w800,
              color: const Color(0xff1E1E1E),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 30,
          ),
          Container(
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const BottomNavigation()),
                      (route) => false,
                );
              },
              style: ElevatedButton.styleFrom(
                primary: ColorValue.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              ),
              child: Text(
                'Lanjutkan',
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );

  bool _isValidEmail(String email) {
    // Validasi input email menggunakan Regular Expression
    RegExp emailRegex = RegExp(
        r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
        caseSensitive: false,
        multiLine: false);

    return emailRegex.hasMatch(email);
  }
}
