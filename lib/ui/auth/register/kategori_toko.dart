import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kangsayur_seller/common/color_value.dart';
import 'package:kangsayur_seller/ui/auth/register/register_toko.dart';

class KategoriToko extends StatefulWidget {
  const KategoriToko({Key? key}) : super(key: key);

  @override
  State<KategoriToko> createState() => _KategoriTokoState();
}

class _KategoriTokoState extends State<KategoriToko> {

  List<bool> isChecked = [false, false, false, false, false, false];
  List<String> categoryNames = [
    "Bahan Pokok",
    "Sayuran",
    "Buah Buahan",
    "Daging",
    "Unggas",
    "Telur"
  ];
  List<String> categoryIcons = [
    "assets/svg/bahan_pokok.svg",
    "assets/svg/sayuran.svg",
    "assets/svg/buah_buahan.svg",
    "assets/svg/daging.svg",
    "assets/svg/ayam.svg",
    "assets/svg/telur.svg"
  ];

  void _navigateToRegisterToko() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => register_toko(
          selectedCategories: isChecked,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Kategori Toko",
          style: TextStyle(color: Colors.black, fontSize: 18),),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => register_toko(selectedCategories: [],)),
                  (Route<dynamic> route) => false),
        ),
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(24),
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
                        isChecked[i],
                            (value) => setState(() => isChecked[i] = value!),
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                Spacer(),
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      _navigateToRegisterToko();
                    },
                    child: Text(
                      'Simpan',
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: ColorValue.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
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
      String nama_kategori,
      String icon_kategori,
      bool isChecked,
      Function(bool?) onChanged,
      ) {
    return Row(
      children: [
        Checkbox(
          value: isChecked,
          onChanged: onChanged,
        ),
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 50,
              height: 50,
              //border radius
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: ColorValue.primaryColor,
              ),
            ),
            SvgPicture.asset(
              icon_kategori,
              width: 30,
              height: 30,
            ),
          ],
        ),
        SizedBox(width: 15),
        Text(
          nama_kategori,
          style: Theme.of(context).textTheme.subtitle1!.copyWith(
            fontWeight: FontWeight.w500,
            fontSize: 16,
            color: ColorValue.neutralColor,
          ),
        ),
      ],
    );
  }

}
