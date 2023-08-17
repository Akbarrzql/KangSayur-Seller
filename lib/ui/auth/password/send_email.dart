import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kangsayur_seller/bloc/bloc/reset_pw_seller_bloc.dart';
import 'package:kangsayur_seller/bloc/state/reset_pw_seller_state.dart';
import 'package:kangsayur_seller/common/color_value.dart';
import 'package:kangsayur_seller/ui/widget/main_button.dart';

import '../../../bloc/event/reset_pw_seller_event.dart';
import '../../../repository/reset_pw_seller_repository.dart';
import '../../../validator/input_validator.dart';
import '../../widget/custom_textfield.dart';
import 'ganti_password.dart';

class SendEmailPage extends StatefulWidget {
  const SendEmailPage({super.key, required this.email});
  final String email;

  @override
  State<SendEmailPage> createState() => _SendEmailPageState();
}

class _SendEmailPageState extends State<SendEmailPage> {

  TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: const BackButton(
          color: Colors.black,
        ),
        title: Text(
          'Lupa Password',
          style: Theme.of(context).textTheme.headline6!.copyWith(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/confirmpassword.png',
                  width: 200,
                  height: 200,
                ),
                const SizedBox(
                  height: 34,
                ),
                 Text(
                  'Lupa Password?',
                  style: textTheme.headline5!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: ColorValue.neutralColor,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  'Masukkan email yang terdaftar untuk mengirimkan link reset password',
                  textAlign: TextAlign.center,
                  style: textTheme.bodyText2!.copyWith(
                    color: ColorValue.hintColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                Column(
                  children: [
                    Text(
                      'Email Terdaftar :',
                      style: textTheme.bodyText2!.copyWith(
                        color: ColorValue.neutralColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  widget.email,
                  style: textTheme.bodyText2!.copyWith(
                    color: ColorValue.hintColor,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // CustomTextFormField(
                //   controller: _emailController,
                //   label: widget.email,
                //   textInputType: TextInputType.emailAddress,
                //   validator: (value) => InputValidator.emailValidator(value),
                // ),
                const SizedBox(
                  height: 50,
                ),
                BlocProvider(
                  create: (context) => ResetPasswordSellerPageBloc(resetPasswordSellerPageRepository: ResetPwSellerRepository()),
                  child: BlocBuilder<ResetPasswordSellerPageBloc, ResetPwSellerState>(
                    builder: (context, state) {
                      if(state is ResetPwSellerInitial){
                        return main_button("Kirim Email", context, onPressed: () {
                          BlocProvider.of<ResetPasswordSellerPageBloc>(context).add(ResetPwSeller());

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              backgroundColor: ColorValue.primaryColor,
                              margin: EdgeInsets.fromLTRB(24, 0, 24, 24),
                              behavior: SnackBarBehavior.floating,
                              content: Text('Email berhasil dikirim'),
                            ),
                          );
                        },);
                      }else if(state is ResetPwSellerLoading){
                        return main_button("Kirim Email", context, onPressed: () {
                          BlocProvider.of<ResetPasswordSellerPageBloc>(context).add(ResetPwSeller());

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              backgroundColor: ColorValue.primaryColor,
                              margin: EdgeInsets.fromLTRB(24, 0, 24, 24),
                              behavior: SnackBarBehavior.floating,
                              content: Text('Email berhasil dikirim'),
                            ),
                          );
                        },);
                      } else if(state is ResetPwSellerSuccess){
                        return main_button("Kirim Email", context, onPressed: () {
                          BlocProvider.of<ResetPasswordSellerPageBloc>(context).add(ResetPwSeller());

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              backgroundColor: ColorValue.primaryColor,
                              margin: EdgeInsets.fromLTRB(24, 0, 24, 24),
                              behavior: SnackBarBehavior.floating,
                              content: Text('Email berhasil dikirim'),
                            ),
                          );
                        },);
                      }else if (state is ResetPwSellerError){
                        return SnackBar(
                          backgroundColor: ColorValue.primaryColor,
                          margin: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                          behavior: SnackBarBehavior.floating,
                          content: Text(state.errorMessage),
                        );
                      }else{
                        return const SizedBox();
                      }
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
