import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kangsayur_seller/common/color_value.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:kangsayur_seller/ui/iklan/iklan.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../pemasukan/pemasukan.dart';
import '../../promo/promo.dart';

class DahsboardPage extends StatefulWidget {
  const DahsboardPage({Key? key}) : super(key: key);

  @override
  State<DahsboardPage> createState() => _DahsboardPageState();
}

class _DahsboardPageState extends State<DahsboardPage> {
  String dropdownValue = 'Bulan Ini';
  late String _selectedMonth;
  late String _selectedMonthGrafik;

  ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _selectedMonth = DateFormat.MMMM('id').format(DateTime.now());
    _selectedMonthGrafik = DateFormat.MMMM('id').format(DateTime.now());
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
          padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
          child: SingleChildScrollView(
            controller: _scrollController,
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(0, 24, 0, 24),
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
                          color: ColorValue.neutralColor),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Analisa",
                      style: textTheme.subtitle1!.copyWith(
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                          color: ColorValue.neutralColor),
                    ),
                    DropdownButton<String>(
                      value: dropdownValue,
                      icon: const Icon(Icons.arrow_drop_down),
                      iconSize: 24,
                      elevation: 16,
                      //underline transparent
                      underline: Container(
                        color: Colors.transparent,
                      ),
                      style: textTheme.subtitle1!.copyWith(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: ColorValue.neutralColor),
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownValue = newValue!;
                        });
                      },
                      items: <String>[
                        'Bulan Ini',
                        '3 Bulan Terakhir',
                        '6 Bulan Terakhir',
                        '1 Tahun Terakhir',
                        'Semua'
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                            value: value, child: Text(value));
                      }).toList(),
                    ),
                  ],
                ),
                Column(
                  children: [
                    if (dropdownValue == 'Bulan Ini')
                      GridView.count(
                        controller: _scrollController,
                        shrinkWrap: true,
                        crossAxisCount: 3,
                        childAspectRatio: 1.5,
                        children: [
                          card_analytic(
                              ColorValue.primaryColor, "Penjualan", "67"),
                          card_analytic(ColorValue.secondaryColor,
                              "Pengunjung toko", "120.000"),
                          card_analytic(
                              const Color(0xFFEE6C4D), "Rating Toko", "4.5"),
                          card_analytic(
                              const Color(0xFF219EBC), "Produk Terjual", "100"),
                          card_analytic(
                              const Color(0xFFF77F00), "Komplain", "0"),
                          card_analytic(const Color(0xFF354F52),
                              "Ulasan Customer", "4.5"),
                        ],
                      )
                    else if (dropdownValue == '3 Bulan Terakhir')
                      GridView.count(
                        shrinkWrap: true,
                        crossAxisCount: 3,
                        childAspectRatio: 1.5,
                        children: [
                          card_analytic(
                              ColorValue.primaryColor, "Penjualan", "200"),
                          card_analytic(ColorValue.secondaryColor,
                              "Pengunjung toko", "350.000"),
                          card_analytic(
                              const Color(0xFFEE6C4D), "Rating Toko", "4.5"),
                          card_analytic(
                              const Color(0xFF219EBC), "Produk Terjual", "180"),
                          card_analytic(
                              const Color(0xFFF77F00), "Komplain", "2"),
                          card_analytic(const Color(0xFF354F52),
                              "Ulasan Customer", "4.2"),
                        ],
                      )
                    else if (dropdownValue == "6 Bulan Terakhir")
                      GridView.count(
                        shrinkWrap: true,
                        crossAxisCount: 3,
                        childAspectRatio: 1.5,
                        children: [
                          card_analytic(
                              ColorValue.primaryColor, "Penjualan", "250"),
                          card_analytic(ColorValue.secondaryColor,
                              "Pengunjung toko", "550.000"),
                          card_analytic(
                              const Color(0xFFEE6C4D), "Rating Toko", "4.5"),
                          card_analytic(
                              const Color(0xFF219EBC), "Produk Terjual", "340"),
                          card_analytic(
                              const Color(0xFFF77F00), "Komplain", "5"),
                          card_analytic(const Color(0xFF354F52),
                              "Ulasan Customer", "4.8"),
                        ],
                      )
                    else if (dropdownValue == "1 Tahun Terakhir")
                      GridView.count(
                        shrinkWrap: true,
                        crossAxisCount: 3,
                        childAspectRatio: 1.5,
                        children: [
                          card_analytic(
                              ColorValue.primaryColor, "Penjualan", "600"),
                          card_analytic(ColorValue.secondaryColor,
                              "Pengunjung toko", "1.000.000"),
                          card_analytic(
                              const Color(0xFFEE6C4D), "Rating Toko", "4.5"),
                          card_analytic(
                              const Color(0xFF219EBC), "Produk Terjual", "460"),
                          card_analytic(
                              const Color(0xFFF77F00), "Komplain", "1"),
                          card_analytic(const Color(0xFF354F52),
                              "Ulasan Customer", "4.6"),
                        ],
                      )
                    else if (dropdownValue == "Semua")
                      GridView.count(
                        shrinkWrap: true,
                        crossAxisCount: 3,
                        childAspectRatio: 1.5,
                        children: [
                          card_analytic(
                              ColorValue.primaryColor, "Penjualan", "800"),
                          card_analytic(ColorValue.secondaryColor,
                              "Pengunjung toko", "1.200.000"),
                          card_analytic(
                              const Color(0xFFEE6C4D), "Rating Toko", "4.5"),
                          card_analytic(
                              const Color(0xFF219EBC), "Produk Terjual", "890"),
                          card_analytic(
                              const Color(0xFFF77F00), "Komplain", "1"),
                          card_analytic(const Color(0xFF354F52),
                              "Ulasan Customer", "4.8"),
                        ],
                      )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Pemasukan",
                  style: textTheme.bodyText1!.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: ColorValue.neutralColor),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total Keseluruhan",
                      style: textTheme.bodyText1!.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: ColorValue.hintColor),
                    ),
                    Text(
                      "Rp. 20.000.000,00",
                      style: textTheme.bodyText1!.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: ColorValue.neutralColor),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
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
                                        color: const Color(0xFF7A7A7A)),
                                  ),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                DropdownButton<String>(
                                  menuMaxHeight: 150,
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
                                  autofocus: true,
                                  items: months.map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value,
                                          style: textTheme.bodyText1!.copyWith(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14,
                                              color: ColorValue.primaryColor)),
                                    );
                                  }).toList(),
                                ),
                              ],
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const DetailPemasukanPage()));
                              },
                              child: Text(
                                "Selengkapnya",
                                style: textTheme.bodyText1!.copyWith(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                    color: ColorValue.hintColor),
                              ),
                            )
                          ],
                        ),
                        if (_selectedMonth == "Januari")
                          text_pemasukan("Rp. 5.000.000,00"),
                        if (_selectedMonth == "Februari")
                          text_pemasukan("Rp. 4.000.000,00"),
                        if (_selectedMonth == "Maret")
                          text_pemasukan("Rp. 3.000.000,00"),
                        if (_selectedMonth == "Mei")
                          text_pemasukan("Rp. 6.000.000,00")
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Grafik Penjualan",
                  style: textTheme.bodyText1!.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: ColorValue.neutralColor),
                ),
                const SizedBox(
                  height: 5,
                ),
                Stack(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      height: 30,
                      width: 300,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: const Color(0xFFE5E5E5),
                      ),
                      child: Text(
                        "Terkahir diperbarui ${DateFormat('dd MMMM yyyy').format(DateTime.now())}, ${DateFormat('HH:mm').format(DateTime.now())} WIB",
                        style: textTheme.bodyText1!.copyWith(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: ColorValue.neutralColor),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Stack(
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
                            value: _selectedMonthGrafik,
                            iconEnabledColor: ColorValue.neutralColor,
                            onChanged: (String? newValue) {
                              setState(() {
                                _selectedMonthGrafik = newValue!;
                              });
                            },
                            underline: Container(
                              height: 0,
                              color: Colors.transparent,
                            ),
                            items: months
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value,
                                    style: textTheme.bodyText1!.copyWith(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                        color: ColorValue.neutralColor)),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Stack(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          height: 30,
                          width: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: const Color(0xFFE5E5E5),
                          ),
                          child: TextButton(
                            onPressed: () {},
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.file_download_outlined,
                                  color: ColorValue.neutralColor,
                                  size: 16,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Download",
                                  style: textTheme.bodyText1!.copyWith(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                      color: ColorValue.neutralColor),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                if (_selectedMonthGrafik == "Januari")
                  SfCartesianChart(
                    primaryXAxis: CategoryAxis(),
                    // Chart title
                    title: ChartTitle(
                        text: 'Data Penjualan Januari',
                        textStyle: textTheme.bodyText1!.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: ColorValue.neutralColor)),
                    // Enable legend and show the legend at the bottom
                    legend: Legend(
                        isVisible: true, position: LegendPosition.bottom),
                    // Enable tooltip
                    tooltipBehavior: TooltipBehavior(enable: true),
                    series: <ChartSeries<SalesData, String>>[
                      LineSeries<SalesData, String>(
                          dataSource: <SalesData>[
                            SalesData('Minggu 1', 35),
                            SalesData('Minggu 2', 28),
                            SalesData('Minggu 3', 34),
                            SalesData('Minggu 4', 32),
                          ],
                          xValueMapper: (SalesData sales, _) => sales.year,
                          yValueMapper: (SalesData sales, _) => sales.sales,
                          color: ColorValue.primaryColor,
                          // Enable data label
                          dataLabelSettings:
                              const DataLabelSettings(isVisible: true))
                    ],
                  ),
                if (_selectedMonthGrafik == "Februari")
                  SfCartesianChart(
                    primaryXAxis: CategoryAxis(),
                    // Chart title
                    title: ChartTitle(
                        text: 'Data Penjualan Februari',
                        textStyle: textTheme.bodyText1!.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: ColorValue.neutralColor)),
                    // Enable legend and show the legend at the bottom
                    legend: Legend(
                        isVisible: true, position: LegendPosition.bottom),
                    // Enable tooltip
                    tooltipBehavior: TooltipBehavior(enable: true),
                    series: <ChartSeries<SalesData, String>>[
                      LineSeries<SalesData, String>(
                          dataSource: <SalesData>[
                            SalesData('Minggu 1', 40),
                            SalesData('Minggu 2', 60),
                            SalesData('Minggu 3', 20),
                            SalesData('Minggu 4', 30),
                          ],
                          xValueMapper: (SalesData sales, _) => sales.year,
                          yValueMapper: (SalesData sales, _) => sales.sales,
                          color: ColorValue.primaryColor,
                          // Enable data label
                          dataLabelSettings:
                              const DataLabelSettings(isVisible: true))
                    ],
                  ),
                if (_selectedMonthGrafik == "Mei")
                  SfCartesianChart(
                    primaryXAxis: CategoryAxis(),
                    // Chart title
                    title: ChartTitle(
                        text: 'Data Penjualan Mei',
                        textStyle: textTheme.bodyText1!.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: ColorValue.neutralColor)),
                    // Enable legend and show the legend at the bottom
                    legend: Legend(
                        isVisible: true, position: LegendPosition.bottom),
                    // Enable tooltip
                    tooltipBehavior: TooltipBehavior(enable: true),
                    series: <ChartSeries<SalesData, String>>[
                      LineSeries<SalesData, String>(
                          dataSource: <SalesData>[
                            SalesData('Minggu 1', 80),
                            SalesData('Minggu 2', 20),
                            SalesData('Minggu 3', 40),
                            SalesData('Minggu 4', 50),
                          ],
                          xValueMapper: (SalesData sales, _) => sales.year,
                          yValueMapper: (SalesData sales, _) => sales.sales,
                          color: ColorValue.primaryColor,
                          // Enable data label
                          dataLabelSettings:
                              const DataLabelSettings(isVisible: true))
                    ],
                  ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Iklan & Promo",
                  style: textTheme.bodyText1!.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: ColorValue.neutralColor),
                ),
                const SizedBox(
                  height: 10,
                ),
                Stack(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      width: double.infinity,
                      height: 195,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: const Color(0xFFE5E5E5),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Tingkatkan interaksi produk anda",
                            style: textTheme.bodyText1!.copyWith(
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                                color: ColorValue.neutralColor),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Interaksi yang bagus akan mempermudah pelanggan dalam menemukan produk anda. Ayo, coba sekarang!",
                            style: textTheme.subtitle1!.copyWith(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                color: ColorValue.neutralColor),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Stack(
                                children: [
                                  ElevatedButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const IklanPage(
                                                      selectedCategories: [],
                                                    )));
                                      },
                                      style: ElevatedButton.styleFrom(
                                        minimumSize: const Size(88, 80),
                                        primary: ColorValue.primaryColor,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                      ),
                                      child: Container(
                                        alignment: Alignment.center,
                                        //image svg and text
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SvgPicture.asset(
                                              "assets/svg/advertisement1.svg",
                                              width: 30,
                                              height: 30,
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              "Iklan",
                                              style: textTheme.bodyText1!
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontSize: 14,
                                                      color: Colors.white),
                                            ),
                                          ],
                                        ),
                                      )),
                                ],
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Stack(
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const PromoPage(
                                                    selectedCategories: [],
                                                  )));
                                    },
                                    style: ElevatedButton.styleFrom(
                                      minimumSize: const Size(88, 80),
                                      primary: ColorValue.primaryColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(
                                          "assets/svg/promotion1.svg",
                                          width: 30,
                                          height: 30,
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          "Promo",
                                          style: textTheme.bodyText1!.copyWith(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 14,
                                              color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget text_pemasukan(String value_harga) {
    final textTheme = Theme.of(context).textTheme;
    return Text(
      value_harga,
      style: textTheme.bodyText1!.copyWith(
          fontWeight: FontWeight.w700,
          fontSize: 24,
          color: ColorValue.neutralColor),
    );
  }

  Widget card_analytic(Color color, String title, String value) {
    return Card(
      color: color,
      child: Container(
          padding: const EdgeInsets.only(left: 10, top: 10),
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
                    color: Colors.white),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                value,
                style: Theme.of(context).textTheme.subtitle1!.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 10,
                    color: Colors.white),
              ),
            ],
          )),
    );
  }

  Widget dropDown_pemasukan() {
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
      items: <String>[
        'Januari',
        'Februari',
        'Maret',
        'April',
        'Mei',
        'Juni',
        'Juli',
        'Agustus',
        'September',
        'Oktober',
        'November',
        'Desember'
      ].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(value: value, child: Text(value));
      }).toList(),
    );
  }
}

class SalesData {
  SalesData(this.year, this.sales);

  final String year;
  final double sales;
}
