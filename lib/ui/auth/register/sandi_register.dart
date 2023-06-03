import 'package:flutter/material.dart';
import 'package:kangsayur_seller/common/color_value.dart';
import 'package:kangsayur_seller/ui/auth/register/map_page.dart';
import '../../widget/dialog_alret.dart';
import '../../widget/main_button.dart';

class KataSandiRegister extends StatefulWidget {
  const KataSandiRegister({Key? key}) : super(key: key);

  @override
  State<KataSandiRegister> createState() => _KataSandiRegisterState();
}

class _KataSandiRegisterState extends State<KataSandiRegister> {

  final _sandiController = TextEditingController();
  final _konfirmasiSandiController = TextEditingController();
  bool isPasswordVisible = true;
  bool isPasswordVisible1 = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: ColorValue.hintColor,
                    width: 0.5,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: TextFormField(
                    controller: _sandiController,
                    obscureText: isPasswordVisible,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Masukkan Kata Sandi Anda',
                      hintStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
                        color: ColorValue.hintColor,
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            isPasswordVisible = !isPasswordVisible;
                          });
                        },
                        icon: Icon(
                          isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                          color: ColorValue.hintColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20,),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: ColorValue.hintColor,
                    width: 0.5,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: TextFormField(
                    controller: _konfirmasiSandiController,
                    obscureText: isPasswordVisible1,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Masukkan Kata Sandi Anda',
                      hintStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
                        color: ColorValue.hintColor,
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            isPasswordVisible1 = !isPasswordVisible1;
                          });
                        },
                        icon: Icon(
                          isPasswordVisible1 ? Icons.visibility : Icons.visibility_off,
                          color: ColorValue.hintColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Spacer(),
              main_button("Lanjut", context, onPressed: () {
                if (_sandiController.text != _konfirmasiSandiController.text) {
                  showErrorDialog(context, "Perhatian", "Kata sandi tidak sama");
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MapScreen()),
                  );
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}
