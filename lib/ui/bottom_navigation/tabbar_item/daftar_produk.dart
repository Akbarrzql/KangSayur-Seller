import 'package:flutter/material.dart';
import 'package:kangsayur_seller/ui/widget/card_produk.dart';

import '../../../common/color_value.dart';

class DaftarProdukPage extends StatefulWidget {
  const DaftarProdukPage({Key? key}) : super(key: key);

  @override
  State<DaftarProdukPage> createState() => _DaftarProdukPageState();
}

class _DaftarProdukPageState extends State<DaftarProdukPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: double.infinity,
          child: Align(
            alignment: Alignment.center,
            child: GridView.builder(
              padding: EdgeInsets.all(24),
              itemCount: 10,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.7,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (context, index) {
                return const CardProduk(
                  hargaProduk: 'Rp 12.000',
                  imageProduk: 'assets/images/wortel.png',
                  jarakProduk: '1.2 km',
                  namaProduk: 'Wortel Lokal 1/Kg',
                  penjualProduk: 'Toko Bu Endah',
                );
              },
            ),
          ),
        ),
      )
    );
  }
}
