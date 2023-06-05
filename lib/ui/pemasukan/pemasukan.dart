import 'package:flutter/material.dart';
import 'package:kangsayur_seller/common/color_value.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../bottom_navigation/item/dashboard.dart';

class DetailPemasukanPage extends StatefulWidget {
  const DetailPemasukanPage({Key? key}) : super(key: key);

  @override
  State<DetailPemasukanPage> createState() => _DetailPemasukanPageState();
}

class _DetailPemasukanPageState extends State<DetailPemasukanPage> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Pemasukan',
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
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Analisis Pemasukan",
                style: Theme.of(context).textTheme.headline6!.copyWith(
                      color: ColorValue.neutralColor,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
              ),
              const SizedBox(height: 10,),
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 1.5,
                children: [
                  CardAnalisis("Pemasukan", "Rp2,320,000", "+12%", const Color(0xFFD7FEDF), "Rp. 1.000.000", ColorValue.primaryColor),
                  CardAnalisis("Konversi", "38%", "-6%", const Color(0xFFFFEAEF), "Rp. 1.000.000", const Color(0xFFD6001C)),
                  CardAnalisis("Produk Terlaris", "59", "+5%", const Color(0xFFD7FEDF), "Rp. 1.000.000", ColorValue.primaryColor),
                  CardAnalisis("Jumlah Transksi", "100", "+10%", const Color(0xFFD7FEDF), "Rp. 1.000.000", ColorValue.primaryColor),
                ],
              ),
              const SizedBox(height: 20,),
              Text(
                "Grafik Jumlah Transaksi",
                style: Theme.of(context).textTheme.headline6!.copyWith(
                  color: ColorValue.neutralColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 10,),
              SfCartesianChart(
                primaryXAxis: CategoryAxis(),
                // Enable legend and show the legend at the bottom
                legend: Legend(isVisible: true, position: LegendPosition.bottom),
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
            ]
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
