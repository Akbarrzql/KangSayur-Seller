import 'package:flutter/material.dart';
import 'package:kangsayur_seller/ui/auth/register/register_toko.dart';

import '../../../common/color_value.dart';

class ListOperasionalToko extends StatefulWidget {
  const ListOperasionalToko({Key? key}) : super(key: key);

  @override
  State<ListOperasionalToko> createState() => _ListOperasionalTokoState();
}

class _ListOperasionalTokoState extends State<ListOperasionalToko> {

  bool _isSetiapHariSelected = false;
  List<bool> isChecked = [false, false, false, false, false, false, false];
  List<String> categoryHari = [
    "Senin",
    "Selasa",
    "Rabu",
    "Kamis",
    "Jumat",
    "Sabtu",
    "Setiap Hari"
  ];

  void _toggleSetiapHari(bool? value) {
    setState(() {
      _isSetiapHariSelected = value ?? false;
      if (value == true) {
        for (var i = 0; i < isChecked.length - 1; i++) {
          isChecked[i] = true;
        }
      }
    });
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
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 24, right: 24, top: 24),
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xffD7FEDF),
                  borderRadius: BorderRadius.circular(10),
                ),
                height: 45,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.info_outline,
                      color: ColorValue.primaryColor,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Text(
                        "Pilih hari operasional toko kamu atau kamu bisa memilih semua hari pada bagian paling bawah.",
                        style: Theme.of(context).textTheme.subtitle1!.copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: 10,
                          color: ColorValue.primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10,),
            Expanded(
              child: ListView.builder(
                itemCount: categoryHari.length,
                itemBuilder: (context, index) {
                  if (index == categoryHari.length - 1) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "Kamu dapat memilih fitur setiap hari",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        CheckboxListTile(
                          title: Text(
                            categoryHari[index],
                            style: textTheme.bodyText1!.copyWith(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          value: index == 6 ? _isSetiapHariSelected : isChecked[index] && !_isSetiapHariSelected,
                          onChanged: index == 6
                              ? _toggleSetiapHari
                              : (bool? value) {
                            setState(() {
                              isChecked[index] = value!;
                            });
                          },
                        ),
                      ],
                    );
                  } else {
                    return CheckboxListTile(
                      title: Text(
                        categoryHari[index],
                        style: textTheme.bodyText1!.copyWith(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      value: index == 6 ? _isSetiapHariSelected : isChecked[index] && !_isSetiapHariSelected,
                      onChanged: index == 6
                          ? _toggleSetiapHari
                          : (bool? value) {
                        setState(() {
                          isChecked[index] = value!;
                        });
                      },
                    );
                  }
                },
              ),
            ),
            Container(
              width: double.infinity,
              height: 50,
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: ElevatedButton(
                onPressed: () {
                  //ketika checkbox setiap hari dipilih maka checkbox dari senin hingga sabtu akan dikirimkan ke register_toko.dart
                  if (_isSetiapHariSelected) {
                    for (var i = 0; i < isChecked.length - 1; i++) {
                      isChecked[i] = true;
                    }
                  }
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => register_toko(selectedCategoriesOperasional: isChecked),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: ColorValue.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'Simpan',
                  style: textTheme.button!.copyWith(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
