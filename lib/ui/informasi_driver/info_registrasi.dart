import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kangsayur_seller/ui/informasi_driver/list_driver.dart';

import '../../common/color_value.dart';
import '../bottom_navigation/bottom_navigation.dart';
import '../widget/main_button.dart';

class InfoRegistrasiDriver extends StatefulWidget {
  const InfoRegistrasiDriver({Key? key}) : super(key: key);

  @override
  State<InfoRegistrasiDriver> createState() => _InfoRegistrasiDriverState();
}

class _InfoRegistrasiDriverState extends State<InfoRegistrasiDriver> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Menunggu Verifikasi',
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
                'Pendaftaran driver berhasil!',
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
                'Setelah pendaftaran berhasil driver di wajibkan untuk menginstall aplikasi KangSayur Driver agar dapat mengantar pesanan pelanggan yang telah dipesan',
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
              main_button("Lihat Data Driver", context, onPressed: (){
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => const ListDriver()),
                        (Route<dynamic> route) => false);
              })
            ],
          ),
        ),
      ),
    );
  }
}
