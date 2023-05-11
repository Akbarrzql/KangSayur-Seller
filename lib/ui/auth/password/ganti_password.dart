import 'package:flutter/material.dart';
import 'package:kangsayur_seller/ui/widget/main_button.dart';
import 'package:kangsayur_seller/ui/widget/textfiled.dart';

import '../../../common/color_value.dart';

class GantiPasswordPage extends StatefulWidget {
  const GantiPasswordPage({Key? key}) : super(key: key);

  @override
  State<GantiPasswordPage> createState() => _GantiPasswordPageState();
}

class _GantiPasswordPageState extends State<GantiPasswordPage> {

  final _passwordLamaController = TextEditingController();
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
            Navigator.pop(context);
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
              "Password Lama",
              style: textTheme.headline6!.copyWith(
                color: ColorValue.neutralColor,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 10,),
            textfield(context, "Masukkan Password Lama", _passwordLamaController, TextInputType.text),
            const SizedBox(height: 20,),
            Text(
              "Password Baru",
              style: textTheme.headline6!.copyWith(
                color: ColorValue.neutralColor,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 10,),
            textfield(context, "Masukkan Password Baru", _passwordBaruController, TextInputType.text),
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
            textfield(context, "Konfirmasi Password Baru Anda", _passwordKonfirmasiBaruController, TextInputType.text),
            Spacer(),
            main_button("Simpan", context, onPressed: (){})
          ],
        ),
      ),
    );
  }
}
