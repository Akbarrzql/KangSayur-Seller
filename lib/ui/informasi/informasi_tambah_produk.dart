import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kangsayur_seller/ui/bottom_navigation/bottom_navigation.dart';
import 'package:kangsayur_seller/ui/widget/main_button.dart';

import '../../common/color_value.dart';
import '../bottom_navigation/item/dashboard.dart';

class InformasiVerifikasiProduk extends StatefulWidget {
  const InformasiVerifikasiProduk({Key? key}) : super(key: key);

  @override
  State<InformasiVerifikasiProduk> createState() => _InformasiVerifikasiProdukState();
}

class _InformasiVerifikasiProdukState extends State<InformasiVerifikasiProduk> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Daftar Promo',
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: SvgPicture.asset(
                  'assets/svg/verifikasi_ilus.svg',
                  width: 250,
                  height: 250,
                ),
              ),
              Text(
                'Barang anda sedang diverifikasi oleh admin',
                style: textTheme.headline6!.copyWith(
                  color: ColorValue.secondaryColor,
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Barang yang kamu tambahkan sedang diverifikasi, tunggu kabar selanjutnya melalui inbox aplikasi ya.',
                textAlign: TextAlign.center,
                style: textTheme.bodyText1!.copyWith(
                  color: ColorValue.neutralColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              main_button("Kembali", context, onPressed: (){
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => const BottomNavigation()),
                        (Route<dynamic> route) => false);
              })
            ],
          ),
        ),
      ),
    );
  }
}
