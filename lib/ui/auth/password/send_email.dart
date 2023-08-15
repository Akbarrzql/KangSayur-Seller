import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kangsayur_seller/common/color_value.dart';
import 'package:kangsayur_seller/ui/widget/main_button.dart';

import '../../../validator/input_validator.dart';
import '../../widget/custom_textfield.dart';
import 'ganti_password.dart';

class SendEmailPage extends StatefulWidget {
  const SendEmailPage({super.key});

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
                CustomTextFormField(
                  controller: _emailController,
                  label: 'Email',
                  textInputType: TextInputType.emailAddress,
                  validator: (value) => InputValidator.emailValidator(value),
                ),
                const SizedBox(
                  height: 50,
                ),
                main_button("Kirim Email", context, onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const GantiPasswordPage()));
                },),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
