import 'package:flutter/material.dart';
import 'package:kangsayur_seller/common/color_value.dart';
import 'package:kangsayur_seller/ui/auth/register/map_page.dart';
import 'package:kangsayur_seller/ui/auth/register/register_toko.dart';
import '../../../validator/input_validator.dart';
import '../../widget/custom_textfield.dart';
import '../../widget/dialog_alret.dart';
import '../../widget/main_button.dart';

class KataSandiRegister extends StatefulWidget {
  KataSandiRegister({Key? key, required this.namaPemilik, required this.emailPemilik, required this.noHpPemilik, required this.alamatPemilik}) : super(key: key);
  final TextEditingController namaPemilik;
  final TextEditingController emailPemilik;
  final TextEditingController noHpPemilik;
  final TextEditingController alamatPemilik;


  @override
  State<KataSandiRegister> createState() => _KataSandiRegisterState();
}

class _KataSandiRegisterState extends State<KataSandiRegister> {

  final _sandiController = TextEditingController();
  final _konfirmasiSandiController = TextEditingController();
  bool isPasswordVisible = true;
  bool isPasswordVisible1 = true;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Container(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20,),
                Text(
                  "Set Sandi",
                  style: Theme.of(context).textTheme.headline5!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: ColorValue.secondaryColor,
                      ),
                ),
                Text(
                  "Masukkan Sandi anda",
                  style: Theme.of(context).textTheme.subtitle1!.copyWith(
                        fontWeight: FontWeight.w800,
                        color: ColorValue.neutralColor,
                      ),
                ),
                const SizedBox(height: 30,),
                CustomTextFormField(
                  controller: _sandiController,
                  label: 'Masukkan Kata Sandi Anda',
                  isPassword: true,
                  textInputType: TextInputType.visiblePassword,
                  validator: (value) => InputValidator.passwordValidator(value),
                ),
                const SizedBox(height: 20,),
                CustomTextFormField(
                  controller: _konfirmasiSandiController,
                  label: 'Konfirmasi Kata Sandi Anda',
                  isPassword: true,
                  textInputType: TextInputType.visiblePassword,
                  validator: (value) => InputValidator.passwordValidator(value),
                ),
                Spacer(),
                main_button("Lanjut", context, onPressed: () {
                  if (_sandiController.text != _konfirmasiSandiController.text) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        backgroundColor: Colors.red,
                        margin: EdgeInsets.fromLTRB(24, 0, 24, 80),
                        behavior: SnackBarBehavior.floating,
                        content: Text('Kata Sandi tidak sama'),
                      ),
                    );
                  } else if (_sandiController.text.isEmpty || _konfirmasiSandiController.text.isEmpty){
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        backgroundColor: Colors.red,
                        margin: EdgeInsets.fromLTRB(24, 0, 24, 80),
                        behavior: SnackBarBehavior.floating,
                        content: Text('Kata Sandi anda tidak terisi'),
                      ),
                    );
                  } else if (_formKey.currentState!.validate())  {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => register_toko(
                        selectedCategoriesOperasional: [],
                        namaPemilik: widget.namaPemilik,
                        emailPemilik: widget.emailPemilik,
                        noHpPemilik: widget.noHpPemilik,
                        alamatPemilik: widget.alamatPemilik,
                        sandi: _sandiController,
                      )),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        backgroundColor: Colors.red,
                        margin: EdgeInsets.fromLTRB(24, 0, 24, 80),
                        behavior: SnackBarBehavior.floating,
                        content: Text('Terdapat kesalahan pada inputan'),
                      ),
                    );
                  }
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
