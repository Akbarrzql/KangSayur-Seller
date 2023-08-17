import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kangsayur_seller/bloc/state/ubah_pw_seller_state.dart';
import 'package:kangsayur_seller/ui/widget/main_button.dart';
import 'package:kangsayur_seller/ui/widget/textfiled.dart';

import '../../../bloc/bloc/ubah_pw_seller_bloc.dart';
import '../../../bloc/event/ubah_pw_seller_event.dart';
import '../../../common/color_value.dart';
import '../../../repository/ubah_pw_seller_repository.dart';
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
    return BlocProvider(
      create: (context) => UbahPwSellerPageBloc(ubahPwSellerPageRepository: UbahPwSellerRepository()),
      child: BlocConsumer<UbahPwSellerPageBloc, UbahPwSellerState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is UbahPwSellerInitial){
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
                    main_button("Simpan", context, onPressed: (){
                      if(_passwordBaruController.text == _passwordKonfirmasiBaruController.text){
                        BlocProvider.of<UbahPwSellerPageBloc>(context).add(UbahPwSeller(password: _passwordBaruController.text));

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            backgroundColor: ColorValue.primaryColor,
                            margin: EdgeInsets.fromLTRB(24, 0, 24, 24),
                            behavior: SnackBarBehavior.floating,
                            content: Text('Password berhasil diubah'),
                          ),
                        );
                      }else{
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Password tidak sama"),
                          ),
                        );
                      }
                    })
                  ],
                ),
              ),
            );
          }else if (state is UbahPwSellerLoading){
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }else if (state is UbahPwSellerSuccess){
            return const BottomNavigation();
          }else if (state is UbahPwSellerError){
            return Scaffold(
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(state.errorMessage),
                    const SizedBox(height: 20,),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const BottomNavigation(),
                            ),
                                (route) => false
                        );
                      },
                      child: const Text('Kembali'),
                    ),
                  ],
                ),
              ),
            );
          }else{
            return Scaffold(
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Terjadi Kesalahan"),
                    const SizedBox(height: 20,),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const BottomNavigation(),
                            ),
                                (route) => false
                        );
                      },
                      child: const Text('Kembali'),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
