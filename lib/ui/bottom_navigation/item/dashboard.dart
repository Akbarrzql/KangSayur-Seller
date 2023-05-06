import 'package:flutter/material.dart';
import 'package:kangsayur_seller/common/color_value.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';


class DahsboardPage extends StatefulWidget {
  const DahsboardPage({Key? key}) : super(key: key);

  @override
  State<DahsboardPage> createState() => _DahsboardPageState();
}

class _DahsboardPageState extends State<DahsboardPage> {

  String dropdownValue = 'Bulan Ini';
  late String _selectedMonth;

  @override
  void initState() {
    super.initState();
    _selectedMonth = DateFormat.MMMM('id').format(DateTime.now());
  }

  List<String> _generateMonthList() {
    List<String> months = [];
    for (int i = 1; i <= 12; i++) {
      DateTime monthDateTime = DateTime(DateTime.now().year, i);
      String monthName = DateFormat.MMMM('id').format(monthDateTime);
      months.add(monthName);
    }
    return months;
  }



  @override
  Widget build(BuildContext context) {

    final textTheme = Theme.of(context).textTheme;
    List<String> months = _generateMonthList();

    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                 const SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Nama Toko",
                    style: textTheme.bodyText1!.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: ColorValue.neutralColor
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Analisa",
                    style: textTheme.subtitle1!.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      color: ColorValue.neutralColor
                    ),
                  ),
                  DropdownButton<String>(
                    value: dropdownValue,
                    icon: const Icon(Icons.arrow_drop_down),
                    iconSize: 24,
                    elevation: 16,
                    style: textTheme.subtitle1!.copyWith(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: ColorValue.neutralColor
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownValue = newValue!;
                      });
                    },
                    items: <String>['Bulan Ini', '3 Bulan Terakhir', '6 Bulan Terakhir', '1 Tahun Terakhir', 'Semua']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value)
                      );
                    }).toList(),
                  ),
                ],
              ),
              Column(
                  children: [
                    if (dropdownValue == 'Bulan Ini')
                      GridView.count(
                        shrinkWrap: true,
                        crossAxisCount: 3,
                        childAspectRatio: 1.5,
                        children: [
                          card_analytic(ColorValue.primaryColor, "Penjualan", "67"),
                          card_analytic(ColorValue.secondaryColor, "Pengunjung toko", "120.000"),
                          card_analytic(Color(0xFFEE6C4D), "Rating", "4.5"),
                          card_analytic(Color(0xFF219EBC), "Produk Terjual", "100"),
                          card_analytic(Color(0xFFF77F00), "Komplain", "0"),
                          card_analytic(Color(0xFF354F52), "Ulasan Customer", "4.5"),
                        ],
                      )
                    else if (dropdownValue == '3 Bulan Terakhir')
                      GridView.count(
                        shrinkWrap: true,
                        crossAxisCount: 3,
                        childAspectRatio: 1.5,
                        children: [
                          card_analytic(ColorValue.primaryColor, "Penjualan", "200"),
                          card_analytic(ColorValue.secondaryColor, "Pengunjung toko", "350.000"),
                          card_analytic(Color(0xFFEE6C4D), "Rating", "4.5"),
                          card_analytic(Color(0xFF219EBC), "Produk Terjual", "180"),
                          card_analytic(Color(0xFFF77F00), "Komplain", "2"),
                          card_analytic(Color(0xFF354F52), "Ulasan Customer", "4.2"),
                        ],
                      )
                    else if (dropdownValue == "6 Bulan Terakhir")
                        GridView.count(
                          shrinkWrap: true,
                          crossAxisCount: 3,
                          childAspectRatio: 1.5,
                          children: [
                            card_analytic(ColorValue.primaryColor, "Penjualan", "250"),
                            card_analytic(ColorValue.secondaryColor, "Pengunjung toko", "550.000"),
                            card_analytic(Color(0xFFEE6C4D), "Rating", "4.5"),
                            card_analytic(Color(0xFF219EBC), "Produk Terjual", "340"),
                            card_analytic(Color(0xFFF77F00), "Komplain", "5"),
                            card_analytic(Color(0xFF354F52), "Ulasan Customer", "4.8"),
                          ],
                        )
                      else if (dropdownValue == "1 Tahun Terakhir")
                          GridView.count(
                            shrinkWrap: true,
                            crossAxisCount: 3,
                            childAspectRatio: 1.5,
                            children: [
                              card_analytic(ColorValue.primaryColor, "Penjualan", "600"),
                              card_analytic(ColorValue.secondaryColor, "Pengunjung toko", "1.000.000"),
                              card_analytic(Color(0xFFEE6C4D), "Rating", "4.5"),
                              card_analytic(Color(0xFF219EBC), "Produk Terjual", "460"),
                              card_analytic(Color(0xFFF77F00), "Komplain", "1"),
                              card_analytic(Color(0xFF354F52), "Ulasan Customer", "4.6"),
                            ],
                          )
                        else if (dropdownValue == "Semua")
                            GridView.count(
                              shrinkWrap: true,
                              crossAxisCount: 3,
                              childAspectRatio: 1.5,
                              children: [
                                card_analytic(ColorValue.primaryColor, "Penjualan", "800"),
                                card_analytic(ColorValue.secondaryColor, "Pengunjung toko", "1.200.000"),
                                card_analytic(Color(0xFFEE6C4D), "Rating", "4.5"),
                                card_analytic(Color(0xFF219EBC), "Produk Terjual", "890"),
                                card_analytic(Color(0xFFF77F00), "Komplain", "1"),
                                card_analytic(Color(0xFF354F52), "Ulasan Customer", "4.8"),
                              ],
                            )
                  ],
                ),
              const SizedBox(height: 20,),
              Text(
                "Pemasukan",
                style: textTheme.bodyText1!.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: ColorValue.neutralColor
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total Keseluruhan",
                    style: textTheme.bodyText1!.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: ColorValue.hintColor
                    ),
                  ),
                  Text(
                    "Rp. 20.000.000,00",
                    style: textTheme.bodyText1!.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: ColorValue.neutralColor
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10,),
              Card(
                color: Colors.white,
                child: Container(
                  padding: const EdgeInsets.only(left: 10),
                  height: 100,
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 15),
                                child: Text(
                                  "Pemasukan",
                                  style: textTheme.bodyText1!.copyWith(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                      color: Color(0xFF7A7A7A)
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8,),
                              DropdownButton<String>(
                                value: _selectedMonth,
                                iconEnabledColor: ColorValue.primaryColor,
                                onChanged: (String? newValue) {
                                  setState(() {
                                    _selectedMonth = newValue!;
                                  });
                                },
                                underline: Container(
                                  height: 0,
                                  color: Colors.transparent,
                                ),
                                items: months.map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(
                                      value,
                                      style: textTheme.bodyText1!.copyWith(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14,
                                          color: ColorValue.primaryColor
                                      )
                                    ),
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                          TextButton(
                            onPressed: (){},
                            child: Text(
                              "Selengkapnya",
                              style: textTheme.bodyText1!.copyWith(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  color: ColorValue.hintColor
                              ),
                            ),
                          )
                        ],
                      ),
                      if (_selectedMonth == "Januari")
                        Text(
                          "Rp. 5.000.000,00",
                          style: textTheme.bodyText1!.copyWith(
                              fontWeight: FontWeight.w700,
                              fontSize: 24,
                              color: ColorValue.neutralColor
                          ),
                        ),
                      if (_selectedMonth == "Februari")
                        Text(
                          "Rp. 4.000.000,00",
                          style: textTheme.bodyText1!.copyWith(
                              fontWeight: FontWeight.w700,
                              fontSize: 24,
                              color: ColorValue.neutralColor
                          ),
                        ),
                      if (_selectedMonth == "Maret")
                        Text(
                          "Rp. 3.000.000,00",
                          style: textTheme.bodyText1!.copyWith(
                              fontWeight: FontWeight.w700,
                              fontSize: 24,
                              color: ColorValue.neutralColor
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20,),
              Text(
                "Grafik Penjualan",
                style: textTheme.bodyText1!.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: ColorValue.neutralColor
                ),
              ),
              const SizedBox(height: 5,),
              Stack(
                children: [
                  Container(
                    alignment: Alignment.center,
                    height: 30,
                    width: 230,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Color(0xFFE5E5E5),
                    ),
                    child: Text(
                      "Terkahir diperbarui ${DateFormat('dd MMMM yyyy').format(DateTime.now())}",
                      style: textTheme.bodyText1!.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: ColorValue.neutralColor
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget card_analytic(Color color, String title, String value) {
    return Card(
      color: color,
      child: Container(
          padding: EdgeInsets.only(left: 10, top: 10),
          height: 50,
          width: 100,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.subtitle1!.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 10,
                    color: Colors.white
                ),
              ),
              SizedBox(height: 5,),
              Text(
                value,
                style: Theme.of(context).textTheme.subtitle1!.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 10,
                    color: Colors.white
                ),
              ),
            ],
          )
      ),
    );
  }

  Widget dropDown_pemasukan(){
    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_drop_down),
      iconSize: 24,
      elevation: 16,
      style: Theme.of(context).textTheme.subtitle1!.copyWith(
        fontWeight: FontWeight.w800,
        fontSize: 16,
        color: ColorValue.neutralColor,
      ),
      onChanged: (String? newValue) {
        setState(() {
          dropdownValue = newValue!;
        });
      },
      items: <String>['Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni', 'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
            value: value,
            child: Text(value)
        );
      }).toList(),
    );
  }


}