import 'package:flutter/material.dart';
import 'package:kangsayur_seller/ui/bottom_navigation/bottom_navigation.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../common/color_value.dart';
import '../bottom_navigation/item/dashboard.dart';

class DetailIklan extends StatefulWidget {
  const DetailIklan({Key? key}) : super(key: key);

  @override
  State<DetailIklan> createState() => _DetailIklanState();
}

class _DetailIklanState extends State<DetailIklan> {

  String dropdownValueIklan = 'Sebulan Terakhir';

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Informasi Iklan',
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
              ),
            );
          },
          icon: const Icon(
            Icons.arrow_back,
            color: ColorValue.neutralColor,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.center,
                height: 30,
                width: 140,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: const Color(0xFFE5E5E5),
                ),
                child: DropdownButton<String>(
                  value: dropdownValueIklan,
                  iconEnabledColor: ColorValue.neutralColor,
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownValueIklan = newValue!;
                    });
                  },
                  underline: Container(
                    height: 0,
                    color: Colors.transparent,
                  ),
                  items: <String>['Sebulan Terakhir', '3 Bulan Terakhir', '6 Bulan Terakhir', '1 Tahun Terakhir', 'Semua']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                          value,
                          style: textTheme.bodyText1!.copyWith(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: ColorValue.neutralColor
                          )
                      ),
                    );
                  }).toList(),
                ),

              ),
              const SizedBox(height: 10,),
              if(dropdownValueIklan == 'Sebulan Terakhir')
                GridView.count  (
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 1.5,
                  children: [
                    CardAnalisis("Pengeluaran", "sebulan terkahir", "+12%", const Color(0xFFD7FEDF), "Rp5,320,000", ColorValue.primaryColor),
                    CardAnalisis("Tayangan Iklan", "sebulan terkahir", "-2%", const Color(0xFFFFEAEF), "58%", const Color(0xFFD6001C)),
                    CardAnalisis("Jumlah Klik", "sebulan terkahir", "+58%", const Color(0xFFD7FEDF), "100", ColorValue.primaryColor),
                    CardAnalisis("Terjual Dari Iklan", "sebulan terkahir", "+10%", const Color(0xFFD7FEDF), "50", ColorValue.primaryColor),
                    CardAnalisis("Pesanan", "sebulan terkahir", "+5 %", const Color(0xFFD7FEDF), "25", ColorValue.primaryColor),
                    CardAnalisis("Pemasukan", "sebulan terkahir", "+10%", const Color(0xFFD7FEDF), "Rp6,000,000", ColorValue.primaryColor),
                  ],
                ),
              if(dropdownValueIklan == '3 Bulan Terakhir')
                GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 1.5,
                  children: [
                    CardAnalisis("Pengeluaran", "3 bulan terkahir", "+12%", const Color(0xFFD7FEDF), "Rp8,320,000", ColorValue.primaryColor),
                    CardAnalisis("Tayangan Iklan", "3 bulan terkahir", "-2%", const Color(0xFFFFEAEF), "79%", const Color(0xFFD6001C)),
                    CardAnalisis("Jumlah Klik", "3 bulan terkahir", "+58%", const Color(0xFFD7FEDF), "140", ColorValue.primaryColor),
                    CardAnalisis("Terjual Dari Iklan", "3 bulan terkahir", "+10%", const Color(0xFFD7FEDF), "60", ColorValue.primaryColor),
                    CardAnalisis("Pesanan", "3 bulan terkahir", "+5 %", const Color(0xFFD7FEDF), "35", ColorValue.primaryColor),
                    CardAnalisis("Pemasukan", "3 bulan terkahir", "+10%", const Color(0xFFD7FEDF), "Rp7,000,000", ColorValue.primaryColor),
                  ],
                ),
              const SizedBox(height: 10,),
              Text(
                "Grafik Jumlah Transaksi",
                style: Theme.of(context).textTheme.headline6!.copyWith(
                  color: ColorValue.neutralColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 10,),
              if (dropdownValueIklan == 'Sebulan Terakhir')
                SfCartesianChart(
                  primaryXAxis: CategoryAxis(),
                  // Enable legend and show the legend at the bottom
                  legend: Legend(isVisible: false, position: LegendPosition.bottom),
                  // Enable tooltip
                  tooltipBehavior: TooltipBehavior(enable: true),
                  series: <ChartSeries<DataPenjualan, String>>[
                    LineSeries<DataPenjualan, String>(
                        dataSource: <DataPenjualan>[
                          DataPenjualan('Minggu 1', 35),
                          DataPenjualan('Minggu 2', 28),
                          DataPenjualan('Minggu 3', 34),
                          DataPenjualan('Minggu 4', 32),
                        ],
                        xValueMapper: (DataPenjualan sales, _) => sales.date,
                        yValueMapper: (DataPenjualan sales, _) => sales.total,
                        color: ColorValue.primaryColor,
                        // Enable data label
                        dataLabelSettings: DataLabelSettings(isVisible: true))
                  ],
                ),
              if (dropdownValueIklan == '3 Bulan Terakhir')
                SfCartesianChart(
                  primaryXAxis: CategoryAxis(),
                  // Enable legend and show the legend at the bottom
                  legend: Legend(isVisible: false, position: LegendPosition.bottom),
                  // Enable tooltip
                  tooltipBehavior: TooltipBehavior(enable: true),
                  series: <ChartSeries<DataPenjualan, String>>[
                    LineSeries<DataPenjualan, String>(
                        dataSource: <DataPenjualan>[
                          DataPenjualan('Minggu 1', 45),
                          DataPenjualan('Minggu 2', 57),
                          DataPenjualan('Minggu 3', 68),
                          DataPenjualan('Minggu 4', 55),
                        ],
                        xValueMapper: (DataPenjualan sales, _) => sales.date,
                        yValueMapper: (DataPenjualan sales, _) => sales.total,
                        color: ColorValue.primaryColor,
                        // Enable data label
                        dataLabelSettings: DataLabelSettings(isVisible: true))
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget CardAnalisis(String title, String data_terakhir, String persen, Color color, String value, Color color_persen){
    return Card(
      elevation: 1,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(5),
          bottomRight: Radius.circular(5),
        ),
      ),
      child: Container(
        height: 85,
        child: Row(
          children: [
            Row(
              children: [
                Container(
                  width: 5,
                  height: 85,
                  decoration: const BoxDecoration(
                    color: ColorValue.primaryColor,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(5),
                      bottomRight: Radius.circular(5),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: Theme.of(context).textTheme.headline6!.copyWith(
                          color: ColorValue.hintColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 8,),
                      Text(
                        value,
                        style: Theme.of(context).textTheme.headline6!.copyWith(
                          color: ColorValue.neutralColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 8,),
                      Row(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            height: 15,
                            width: 31,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2),
                              color: color,
                            ),
                            child: Text(
                              persen,
                              style: Theme.of(context).textTheme.subtitle1!.copyWith(
                                fontWeight: FontWeight.w500,
                                fontSize: 10,
                                color: color_persen,
                              ),
                            ),
                          ),
                          const SizedBox(width: 4,),
                          Text(
                            data_terakhir,
                            style: Theme.of(context).textTheme.subtitle1!.copyWith(
                              fontWeight: FontWeight.w500,
                              fontSize: 10,
                              color: ColorValue.hintColor,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

}

