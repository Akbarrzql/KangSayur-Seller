import 'package:flutter/material.dart';

import '../../common/color_value.dart';
import '../promo/promo.dart';

class KategoriProdukPage extends StatefulWidget {
  const KategoriProdukPage({Key? key}) : super(key: key);

  @override
  State<KategoriProdukPage> createState() => _KategoriProdukPageState();
}

class _KategoriProdukPageState extends State<KategoriProdukPage> {


  List<bool> isChecked = [false, false, false, false, false, false];
  List<String> categoryNames = [
    "Beras",
    "Kentang",
    "Apel",
    "Daging",
    "Ayam",
    "Telur"
  ];
  List<String> categoryIcons = [
    "assets/images/wortel.png",
    "assets/images/wortel.png",
    "assets/images/wortel.png",
    "assets/images/wortel.png",
    "assets/images/wortel.png",
    "assets/images/wortel.png",
  ];

  //rating produk ist
  List<String> ratingProduk = [
    "4.5",
    "4.5",
    "4.5",
    "4.5",
    "4.5",
    "4.5",
  ];

  //produk terjual
  List<String> produkTerjual = [
    "50 Terjual",
    "80 Terjual",
    "30 Terjual",
    "40 Terjual",
    "5 Terjual",
    "6 Terjual",
  ];

  //list harga
List<String> hargaProduk = [
    "Rp 50.000",
    "Rp 80.000",
    "Rp 30.000",
    "Rp 40.000",
    "Rp 5.000",
    "Rp 6.000",
  ];

  void _navigateToRegisterToko() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PromoPage(
          selectedCategories: isChecked,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Pilih Kategori Produk',
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
          padding: const EdgeInsets.all(24),
          child: Container(
            child: Column(
              children: [
                for (var i = 0; i < categoryNames.length; i++)
                  Column(
                    children: [
                      _kategori_lapak(
                        context,
                        categoryNames[i],
                        categoryIcons[i],
                        ratingProduk[i],
                        produkTerjual[i],
                        isChecked[i],
                            (value) => setState(() => isChecked[i] = value!),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                const Spacer(),
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      _navigateToRegisterToko();
                    },
                    style: ElevatedButton.styleFrom(
                      primary: ColorValue.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: Text(
                      'Simpan',
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _kategori_lapak(
      BuildContext context,
      String nama_produk,
      String foto_produk,
      String rating_produk,
      String produk_terjual,
      bool isChecked,
      Function(bool?) onChanged,
      ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Checkbox(
          value: isChecked,
          onChanged: onChanged,
        ),
        //image container radius 8
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
          ),
          child: Image.asset(
            foto_produk,
            width: 50,
            height: 50,
          ),
        ),
        const SizedBox(width: 15),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              nama_produk,
              style: Theme
                  .of(context)
                  .textTheme
                  .subtitle1!
                  .copyWith(
                fontWeight: FontWeight.w500,
                fontSize: 16,
                color: ColorValue.neutralColor,
              ),
            ),
            const SizedBox(height: 5),
            //icon star warna kuning
            Row(
              children: [
                const Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: 16,
                ),
                Text(
                  rating_produk,
                  style: Theme
                      .of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                    color: ColorValue.neutralColor,
                  ),
                ),
                const VerticalDivider(
                  color: ColorValue.primaryColor,
                  thickness: 1, //ukuran ketebalan garis
                  indent: 5, //jarak garis ke atas
                  endIndent: 5, //jarak garis ke bawah
                ),
                Text(
                  produk_terjual,
                  style: Theme
                      .of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                    color: ColorValue.neutralColor,
                  ),
                ),
              ],
            ),
          ],
        )
      ],
    );
  }
}
