import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:kangsayur_seller/ui/widget/main_button.dart';
import 'package:kangsayur_seller/ui/widget/textfiled.dart';

import '../../../common/color_value.dart';
import '../../../validator/input_validator.dart';
import '../../bottom_navigation/bottom_navigation.dart';
import '../../widget/custom_textfield.dart';

class GantiPasswordPage extends StatefulWidget {
  const GantiPasswordPage({Key? key}) : super(key: key);

  @override
  State<GantiPasswordPage> createState() => _GantiPasswordPageState();
}

class _GantiPasswordPageState extends State<GantiPasswordPage> {

  final _passwordBaruController = TextEditingController();
  final _passwordKonfirmasiBaruController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Pengaturan Akun',
          style: Theme.of(context).textTheme.headline6!.copyWith(
            color: ColorValue.neutralColor,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const BottomNavigation(),
                )
            );
          },
          icon: const Icon(
            Icons.arrow_back,
            color: ColorValue.neutralColor,
          ),
        ),
      ),
      body: SafeArea(
        minimum: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Password Baru",
              style: textTheme.headline6!.copyWith(
                color: ColorValue.neutralColor,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 10,),
            CustomTextFormField(
              controller: _passwordBaruController,
              label: 'Masukkan Password Baru Anda',
              isPassword: true,
              textInputType: TextInputType.visiblePassword,
              validator: (value) => InputValidator.passwordValidator(value),
            ),
            const SizedBox(height: 20,),
            Text(
              "Konfirmasi Password Baru",
              style: textTheme.headline6!.copyWith(
                color: ColorValue.neutralColor,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 10,),
            CustomTextFormField(
              controller: _passwordKonfirmasiBaruController,
              label: 'Masukkan Password Baru Anda',
              isPassword: true,
              textInputType: TextInputType.visiblePassword,
              validator: (value) => InputValidator.passwordValidator(value),
            ),
            const Spacer(),
            main_button("Simpan", context, onPressed: (){})
          ],
        ),
      ),
    );
  }
}
