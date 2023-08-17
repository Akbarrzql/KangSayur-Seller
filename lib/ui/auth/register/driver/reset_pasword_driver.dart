import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kangsayur_seller/bloc/state/ubah_pw_driver_state.dart';
import 'package:kangsayur_seller/ui/informasi_driver/detail_driver.dart';

import '../../../../bloc/bloc/ubah_pw_driver_bloc.dart';
import '../../../../bloc/event/ubah_pw_driver_event.dart';
import '../../../../common/color_value.dart';
import '../../../../model/list_all_driver_model.dart';
import '../../../../repository/ubah_pw_driver_repository.dart';

class ResetPasswordDriver extends StatefulWidget {
  const ResetPasswordDriver({Key? key, required this.data}) : super(key: key);
  final Produk data;

  @override
  State<ResetPasswordDriver> createState() => _ResetPasswordDriverState();
}

class _ResetPasswordDriverState extends State<ResetPasswordDriver> {
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  bool _obscureText = true;
  bool _obscureText2 = true;
  bool _obscureText3 = true;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return BlocProvider(
      create: (context) => UbahPwDriverPageBloc(ubahPwDriverPageRepository: UbahPwDriverRepository()),
      child: BlocConsumer<UbahPwDriverPageBloc, UbahPwDriverState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is UbahPwDriverInitial){
            return Scaffold(
              backgroundColor: const Color(0xFF0E4F55),
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                actions: [
                  InkWell(
                    onTap: () {
                      BlocProvider.of<UbahPwDriverPageBloc>(context).add(UbahPwDriver(driverId: widget.data.driverId.toString(), password: passwordController.text));
                    },
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Text(
                        'Simpan',
                        style: textTheme.headline6!.copyWith(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              body: SafeArea(
                child: SingleChildScrollView(
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 60, 0, 0),
                        child: Expanded(
                          child: Container(
                            height: MediaQuery.of(context).size.height,
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 28, vertical: 30),
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(25),
                                    topRight: Radius.circular(25))),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _listData("Password Baru", "Masukkan Password Baru", passwordController, TextInputType.visiblePassword, _obscureText2),
                                const SizedBox(height: 20,),
                                _listData("Konfirmasi Password Baru", "Konfirmasi Password Baru", confirmPasswordController, TextInputType.visiblePassword, _obscureText3),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          }else if (state is UbahPwDriverLoading){
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }else if(state is UbahPwDriverSuccess) {
            return DetailDriver(
              data: widget.data,
            );
          }else if(state is UbahPwDriverError){
            return Scaffold(
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Terjadi Kesalahan"),
                    const SizedBox(height: 20,),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Kembali'),
                    ),
                  ],
                ),
              ),
            );
          }else {
            return Scaffold(
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Terjadi Kesalahan"),
                    const SizedBox(height: 20,),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
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

  Widget _listData(
      String tittle,
      String hinrText,
      TextEditingController textEditingController,
      TextInputType keyboardType,
      bool hidePassword) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            tittle,
            style: textTheme.headline6!.copyWith(
              color: ColorValue.neutralColor,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Container(
            alignment: Alignment.centerLeft,
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xFFF5F5F5),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, ),
              child: TextField(
                controller: textEditingController,
                keyboardType: keyboardType,
                textInputAction: TextInputAction.next,
                obscureText: hidePassword,
                style: textTheme.bodyText2!.copyWith(
                  color: ColorValue.neutralColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: hinrText,
                  hintStyle: textTheme.bodyText2!.copyWith(
                    color: ColorValue.neutralColor.withOpacity(0.5),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        if (tittle == "Password Lama") {
                          _obscureText = !_obscureText;
                        } else if (tittle == "Password Baru") {
                          _obscureText2 = !_obscureText2;
                        } else {
                          _obscureText3 = !_obscureText3;
                        }
                      });
                    },
                    icon: Icon(
                      hidePassword ? Icons.visibility_off : Icons.visibility,
                      color: ColorValue.neutralColor.withOpacity(0.5),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
