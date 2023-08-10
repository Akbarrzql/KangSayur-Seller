import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kangsayur_seller/ui/auth/register/driver/reset_pasword_driver.dart';
import 'package:kangsayur_seller/ui/informasi_driver/informasi_driver.dart';

import '../../common/color_value.dart';
import '../../model/list_all_driver_model.dart';

class DetailDriver extends StatefulWidget {
  const DetailDriver({Key? key, required this.data}) : super(key: key);
  final Produk data;

  @override
  State<DetailDriver> createState() => _DetailDriverState();
}

class _DetailDriverState extends State<DetailDriver> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme
        .of(context)
        .textTheme;
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
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(28, 50, 28, 0),
              child: Column(
                children: [
                  Center(
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(
                          'https://kangsayur.nitipaja.online${widget.data.fotoDriver.toString()}'),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    widget.data.namaDriver,
                    style: textTheme.headline6!.copyWith(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "+62${widget.data.nomorTelfon.toString()}",
                    style: textTheme.headline6!.copyWith(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 50),
            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                    horizontal: 28, vertical: 30),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25)
                    )
                ),
                child: Column(
                  children: [
                    _listMenu(
                      "Detail Informasi",
                      const Icon(
                        Icons.info_outline_rounded,
                        color: ColorValue.neutralColor,
                      ),
                      ColorValue.neutralColor,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailInformasiDriverPage(
                              data: widget.data,
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                    _listMenu(
                      "Reset Password",
                      const Icon(
                        Icons.lock_outline_rounded,
                        color: ColorValue.neutralColor,
                      ),
                      ColorValue.neutralColor,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ResetPasswordDriver(),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                    _listMenu(
                      "Hapus Akun Driver",
                      const Icon(
                        Icons.logout,
                        color: Colors.red,
                      ),
                      Colors.red,
                      onTap: () {},
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  //paramater on tap
  Widget _listMenu(String title, Icon icon, Color color,{required VoidCallback onTap}) {
    final textTheme = Theme
        .of(context)
        .textTheme;
    return InkWell(
      onTap: onTap,
      splashColor: Colors.white,
      borderRadius: BorderRadius.circular(12.5),
      child: Row(
        children: [
          Container(
              height: 45,
              width: 45,
              decoration: const BoxDecoration(
                color: Color(0XFFF9F9F9),
                borderRadius: BorderRadius.all(
                  Radius.circular(12.5),
                ),
              ),
              child: icon
          ),
          const SizedBox(width: 15),
          Text(
            title,
            style: textTheme.bodyText1!.copyWith(
                color: color
            ),
          ),
          const Spacer(),
          const Icon(Icons.navigate_next_sharp)
        ],
      ),
    );
  }
}
