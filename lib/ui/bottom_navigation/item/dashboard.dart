import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kangsayur_seller/Constants/app_constants.dart';
import 'package:kangsayur_seller/bloc/bloc/dashboard_bloc.dart';
import 'package:kangsayur_seller/bloc/bloc/profile_bloc.dart';
import 'package:kangsayur_seller/bloc/event/profile_event.dart';
import 'package:kangsayur_seller/bloc/state/dashboard_state.dart';
import 'package:kangsayur_seller/bloc/state/profile_state.dart';
import 'package:kangsayur_seller/common/color_value.dart';
import 'package:intl/intl.dart';
import 'package:kangsayur_seller/model/analisa_model.dart';
import 'package:kangsayur_seller/model/grafik_model.dart';
import 'package:kangsayur_seller/repository/analisa_repository.dart';
import 'package:kangsayur_seller/repository/pemasukan_repository.dart';
import 'package:kangsayur_seller/repository/profile_repository.dart';
import 'package:kangsayur_seller/ui/chart/chart.dart';
import 'package:kangsayur_seller/ui/iklan/iklan.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:http/http.dart' as http;
import '../../../bloc/event/dashboard_event.dart';
import '../../../model/pemasukan_model.dart';
import '../../../model/user_model.dart';
import '../../../repository/grafik_repository.dart';
import '../../pemasukan/pemasukan.dart';
import '../../promo/promo.dart';

class DahsboardPage extends StatefulWidget {
  const DahsboardPage({Key? key}) : super(key: key);

  @override
  State<DahsboardPage> createState() => _DahsboardPageState();
}

class _DahsboardPageState extends State<DahsboardPage> {
  String dropdownValue = 'Bulan Ini';
  String _selectedMonth = 'Bulan Ini';
  String _selectedMonthGrafik = 'Bulan Ini';
  DateTimeRange? selectedDate, selectedDateGrafik, selectedDateAnalisa;

  ScrollController _scrollController = ScrollController();
  TextEditingController pemasukanController = TextEditingController();

  PemasukanModel? pemasukanModel;
  AnalisaModel? analisaModel;
  GrafikModel? grafikModel;
  UserModel? userModel;
  late DashboardPageBloc dashboardPageBloc;



  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    dashboardPageBloc = DashboardPageBloc(pemasukanRepository: PemasukanRepository(), analisaRepository: AnalisaRepository(), grafikRepository: GrafikRepository());
  }

  //void format angka ke rupiah dengan paramter untuk diisi data api 
  String formatRupiah(String? data) {
    return NumberFormat.currency(locale: 'id', symbol: 'Rp ', decimalDigits: 0).format(int.parse(data!));
  }
  
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: SafeArea(child: Container(
          padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
          child: SingleChildScrollView(
            controller: _scrollController,
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(0, 24, 0, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BlocProvider(
                  create: (context) => ProfilePageBloc(profilePageRepository: ProfileRepository())..add(GetProfile()),
                  child: BlocBuilder<ProfilePageBloc, ProfilePageState>(
                    builder: (context, state){
                      if (state is ProfilePageLoading) {
                        return Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Row(
                            children: [
                              const CircleAvatar(
                                radius: 20,
                                backgroundColor: Colors.white,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Container(
                                height: 20,
                                width: 100,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        );
                      }
                      else if (state is ProfilePageLoaded){
                        return Row(
                          children: [
                            CircleAvatar(
                              radius: 20,
                              backgroundImage: Image.network(
                                  "https://kangsayur.nitipaja.online/${state.userModel.data.imgProfile}" == null ? "https://avatars.githubusercontent.com/u/60261133?v=4" : "https://kangsayur.nitipaja.online/${state.userModel.data.imgProfile}"
                              ).image,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              state.userModel.data.namaToko,
                              style: textTheme.bodyText1!.copyWith(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  color: ColorValue.neutralColor),
                            ),
                          ],
                        );
                      }
                      else if (state is ProfilePageError){
                        return Text(
                          "Kesalahan dalam mengambil data",
                          style: textTheme.bodyText1!.copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: ColorValue.neutralColor),
                        );
                      }
                      else{
                        return Text(
                          "Kesalahan dalam mengambil data",
                          style: textTheme.bodyText1!.copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: ColorValue.neutralColor),
                        );
                      }
                    },
                  )
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
                        menuMaxHeight: 150,
                        value: _selectedMonth,
                        iconEnabledColor: ColorValue.neutralColor,
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedMonth = newValue!;
                            if (_selectedMonth == "Bulan Ini") {
                              dashboardPageBloc.add(GetData(custom: '1'));
                            } else if (_selectedMonth == "3 Bulan Terakhir") {
                              dashboardPageBloc.add(GetData(custom: '2'));
                            } else if (_selectedMonth == "6 Bulan Terakhir") {
                              dashboardPageBloc.add(GetData(custom: '3'));
                            } else if (_selectedMonth == "1 Tahun Terakhir") {
                              dashboardPageBloc.add(GetData(custom: '4'));
                            }
                          });
                        },
                        underline: Container(
                          height: 0,
                          color: Colors.transparent,
                        ),
                        autofocus: true,
                        items: _months
                            .map<DropdownMenuItem<String>>(
                                (String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value,
                                style: textTheme.subtitle1!.copyWith(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                    color: ColorValue.neutralColor),)
                              );
                            }).toList(),
                        onTap: () {
                          _selectedMonth = _selectedMonth;
                          if (_selectedMonth == "Kustomisasi") {
                            showDatePickerDialog(context, 1);
                          } else {
                            _selectedMonth = _selectedMonth;
                            selectedDate = selectedDate;
                          }
                        }),
                  ],
                ),
                BlocProvider(
                  create: (context) => dashboardPageBloc..add(GetData(custom: '1')),
                  child: BlocBuilder<DashboardPageBloc, DashboardPageState>(
                    builder: (context, state) {
                      if (state is DashboardPageLoading) {
                        return Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: GridView.count(
                            shrinkWrap: true,
                            crossAxisCount: 3,
                            childAspectRatio: 1.5,
                            children: [
                              card_analytic(
                                  ColorValue.primaryColor, "Penjualan", "0"),
                              card_analytic(ColorValue.secondaryColor,
                                  "Pengunjung toko", "0"),
                              card_analytic(
                                  const Color(0xFFEE6C4D), "Rating Toko", "0"),
                              card_analytic(
                                  const Color(0xFF219EBC), "Produk Terjual", "0"),
                              card_analytic(
                                  const Color(0xFFF77F00), "Komplain", "0"),
                              card_analytic(const Color(0xFF354F52),
                                  "Ulasan Customer", "0"),
                            ],
                          ),
                        );
                      } else if (state is DashboardPageLoaded) {
                        return GridView.count(
                          shrinkWrap: true,
                          crossAxisCount: 3,
                          childAspectRatio: 1.5,
                          children: [
                            card_analytic(
                                ColorValue.primaryColor, "Penjualan", state.analisaModel.data.pesanan.toString()),
                            card_analytic(ColorValue.secondaryColor,
                                "Pengunjung toko", state.analisaModel.data.pengunjungToko.toString()),
                            card_analytic(
                                const Color(0xFFEE6C4D), "Rating Toko", state.analisaModel.data.ratingPelayanan.toString()),
                            card_analytic(
                                const Color(0xFF219EBC), "Produk Terjual", state.analisaModel.data.produkTerjual.toString()),
                            card_analytic(
                                const Color(0xFFF77F00), "Komplain", state.analisaModel.data.laporan.toString()),
                            card_analytic(const Color(0xFF354F52),
                                "Ulasan Customer", state.analisaModel.data.ratingProduk.toString()),
                          ],
                        );
                      } else if (state is DashboardPageError) {
                        return Text(
                          "Error",
                          style: textTheme.bodyText1!.copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              color: ColorValue.primaryColor),
                        );
                      } else {
                        return Text(
                          "Rp. 0",
                          style: textTheme.bodyText1!.copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              color: ColorValue.primaryColor),
                        );
                      }
                    },
                  ),
                ),
                if (dropdownValue == "Semua")
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
                        ),
                if (dropdownValue == "Kustomisasi")
                  if(selectedDateAnalisa != null)
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
                  else
                    ElevatedButton(
                              onPressed: () => showDatePickerDialog(context, 3),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  side: const BorderSide(
                                      color: ColorValue.primaryColor),
                                ),
                              ),
                              child: Text(
                                "Pilih Tanggal",
                                style: textTheme.bodyText1!.copyWith(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                    color: ColorValue.primaryColor),
                              ),
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
                    blocPemasukanTotal('1')
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
                                DropdownButton<String>(
                                    menuMaxHeight: 150,
                                    value: _selectedMonth,
                                    iconEnabledColor: ColorValue.primaryColor,
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        _selectedMonth = newValue!;
                                        if (_selectedMonth == "Bulan Ini") {
                                          dashboardPageBloc.add(GetData(custom: '1'));
                                        } else if (_selectedMonth == "3 Bulan Terakhir") {
                                          dashboardPageBloc.add(GetData(custom: '2'));
                                        } else if (_selectedMonth == "6 Bulan Terakhir") {
                                          dashboardPageBloc.add(GetData(custom: '3'));
                                        } else if (_selectedMonth == "1 Tahun Terakhir") {
                                          dashboardPageBloc.add(GetData(custom: '4'));
                                        }
                                      });
                                    },
                                    underline: Container(
                                      height: 0,
                                      color: Colors.transparent,
                                    ),
                                    autofocus: true,
                                    items: _months
                                        .map<DropdownMenuItem<String>>(
                                            (String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value,
                                                style: textTheme.bodyText1!
                                                    .copyWith(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 14,
                                                    color: ColorValue
                                                        .primaryColor)),
                                          );
                                        }).toList(),
                                    onTap: () {
                                      _selectedMonth = _selectedMonth;
                                      if (_selectedMonth == "Kustomisasi") {
                                        showDatePickerDialog(context, 1);
                                      } else {
                                        _selectedMonth = _selectedMonth;
                                        selectedDate = selectedDate;
                                      }
                                    }),
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
                        BlocProvider(
                          create: (context) => dashboardPageBloc..add(GetData(custom: '1')),
                          child: BlocBuilder<DashboardPageBloc, DashboardPageState>(
                            builder: (context, state) {
                              if (state is DashboardPageLoading) {
                                return Shimmer.fromColors(
                                  baseColor: Colors.grey[300]!,
                                  highlightColor: Colors.grey[100]!,
                                  child: Container(
                                    height: 20,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[300],
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                  ),
                                );
                              } else if (state is DashboardPageLoaded) {
                                return Text(
                                  NumberFormat.currency(
                                      locale: 'id', symbol: 'Rp. ', decimalDigits: 0)
                                      .format(state.pemasukanModel.pemasukan.pemasukanPilihan),
                                  style: textTheme.bodyText1!.copyWith(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 24,
                                      color: ColorValue.neutralColor),
                                );
                              } else if (state is DashboardPageError) {
                                return Text(
                                  "Error",
                                  style: textTheme.bodyText1!.copyWith(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                      color: ColorValue.primaryColor),
                                );
                              } else {
                                return Text(
                                  "Rp. 0",
                                  style: textTheme.bodyText1!.copyWith(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                      color: ColorValue.primaryColor),
                                );
                              }
                            },
                          ),
                        ),
                        if (_selectedMonth == "Semua")
                          text_pemasukan("Rp. 20.000.000,00"),
                        if (_selectedMonth == "Kustomisasi")
                          if (selectedDate != null)
                            if (selectedDate!.start.day >= 1 &&
                                selectedDate!.end.day <= 15)
                              text_pemasukan("Rp. 5.000.000,00")
                            else
                              text_pemasukan("Rp. 10.000.000,00")
                          else
                            ElevatedButton(
                              onPressed: () => showDatePickerDialog(context, 1),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  side: const BorderSide(
                                      color: ColorValue.primaryColor),
                                ),
                              ),
                              child: Text(
                                "Pilih Tanggal",
                                style: textTheme.bodyText1!.copyWith(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                    color: ColorValue.primaryColor),
                              ),
                            )
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
                            value: _selectedMonth,
                            iconEnabledColor: ColorValue.neutralColor,
                            onChanged: (String? newValue) {
                              setState(() {
                                _selectedMonth = newValue!;
                                if (_selectedMonth == "Bulan Ini") {
                                  dashboardPageBloc.add(GetData(custom: '1'));
                                } else if (_selectedMonth == "3 Bulan Terakhir") {
                                  dashboardPageBloc.add(GetData(custom: '2'));
                                } else if (_selectedMonth == "6 Bulan Terakhir") {
                                  dashboardPageBloc.add(GetData(custom: '3'));
                                } else if (_selectedMonth == "1 Tahun Terakhir") {
                                  dashboardPageBloc.add(GetData(custom: '4'));
                                }
                              });
                            },
                            underline: Container(
                              height: 0,
                              color: Colors.transparent,
                            ),
                            items: _months
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
                            onTap: () {
                              _selectedMonthGrafik = _selectedMonthGrafik;
                              if (_selectedMonthGrafik == "Kustomisasi") {
                                showDatePickerDialog(context, 2);
                              } else {
                                _selectedMonthGrafik = _selectedMonthGrafik;
                                selectedDateGrafik = selectedDateGrafik;
                              }
                            },
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
                BlocProvider(
                  create: (context) => dashboardPageBloc..add(GetData(custom: '1')),
                  child: BlocBuilder<DashboardPageBloc, DashboardPageState>(
                    builder: (context, state) {
                      if (state is DashboardPageLoading) {
                        return Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Container(
                            height: 200,
                            width: 300,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.white,
                            ),
                          ),
                        );
                      } else if (state is DashboardPageLoaded) {
                        return InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => ChartHorizotalPage(
                              dataPenjualan: getSalesData(),
                              dataPenjualanDateList: getSalesData(),
                            )));
                          },
                          child: SfCartesianChart(
                            enableAxisAnimation: true,
                            primaryXAxis: CategoryAxis(),
                            // Chart title
                            title: ChartTitle(
                                text: 'Data Penjualan Bulan Ini',
                                textStyle: textTheme.bodyText1!.copyWith(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                    color: ColorValue.neutralColor)),
                            zoomPanBehavior: ZoomPanBehavior(
                                enablePinching: true,
                                enableDoubleTapZooming: true,
                                enablePanning: true),
                            // Enable tooltip
                            tooltipBehavior: TooltipBehavior(enable: true),
                            series: <ChartSeries<DataPenjualan, String>>[
                              LineSeries<DataPenjualan, String>(
                                dataSource: <DataPenjualan>[
                                  for(var i = 0; i < state.grafikModel.grafikPenjualan.length ; i++)
                                    DataPenjualan(state.grafikModel.grafikPenjualan[i].date, state.grafikModel.grafikPenjualan[i].total.toDouble())
                                ],
                                xValueMapper: (DataPenjualan data, _) => data.date,
                                yValueMapper: (DataPenjualan data, _) => data.total,
                                color: ColorValue.primaryColor,
                                // Enable data label
                                dataLabelSettings:
                                const DataLabelSettings(isVisible: true),)
                            ],
                          ),
                        );
                      } else if (state is DashboardPageError) {
                        return Text(
                          "Error",
                          style: textTheme.bodyText1!.copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              color: ColorValue.primaryColor),
                        );
                      } else {
                        return Text(
                          "Rp. 0",
                          style: textTheme.bodyText1!.copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              color: ColorValue.primaryColor),
                        );
                      }
                    },
                  ),
                ),
                if (_selectedMonthGrafik == "Kustomisasi")
                  if (selectedDateGrafik != null)
                    SfCartesianChart(
                      enableAxisAnimation: true,
                      primaryXAxis: CategoryAxis(),
                      title: ChartTitle(
                          text:
                          'Data Penjualan Dari Tanggal \n ${DateFormat('dd MMMM yyyy').format(
                            selectedDateGrafik!.start,
                          )}',
                          textStyle: textTheme.bodyText1!.copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              color: ColorValue.neutralColor)),
                      legend: Legend(
                          isVisible: true, position: LegendPosition.bottom),
                      zoomPanBehavior: ZoomPanBehavior(
                          enablePinching: true,
                          enableDoubleTapZooming: true,
                          enablePanning: true),
                      tooltipBehavior: TooltipBehavior(enable: true),
                      series: <ChartSeries<DataPenjualan, String>>[
                        LineSeries<DataPenjualan, String>(
                            dataSource: <DataPenjualan>[
                              DataPenjualan('Minggu 1', 80),
                              DataPenjualan('Minggu 2', 20),
                              DataPenjualan('Minggu 3', 40),
                              DataPenjualan('Minggu 4', 50),
                            ],
                            xValueMapper: (DataPenjualan data, _) => data.date,
                            yValueMapper: (DataPenjualan data, _) => data.total,
                            color: ColorValue.primaryColor,
                            dataLabelSettings:
                            const DataLabelSettings(isVisible: true))
                      ],
                    )
                  else
                    ElevatedButton(
                      onPressed: () => showDatePickerDialog(context, 2),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                          side:
                          const BorderSide(color: ColorValue.primaryColor),
                        ),
                      ),
                      child: Text(
                        "Pilih Tanggal",
                        style: textTheme.bodyText1!.copyWith(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: ColorValue.primaryColor),
                      ),
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
                                        backgroundColor: ColorValue.primaryColor,
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
                                      backgroundColor: ColorValue.primaryColor,
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

  Widget text_pemasukan(String valueHarga) {
    final textTheme = Theme.of(context).textTheme;
    return Text(
      valueHarga,
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

  Widget blocPemasukanTotal(String custom){
    final textTheme = Theme.of(context).textTheme;
    return BlocProvider(
      create: (context) => DashboardPageBloc(pemasukanRepository: PemasukanRepository(), analisaRepository: AnalisaRepository(), grafikRepository: GrafikRepository())..add(GetData(custom: '1')),
      child: BlocBuilder<DashboardPageBloc, DashboardPageState>(
        builder: (context, state) {
          if (state is DashboardPageLoading) {
            return Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                height: 20,
                width: 100,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            );
          } else if (state is DashboardPageLoaded) {
            return Text(
              NumberFormat.currency(
                  locale: 'id', symbol: 'Rp. ', decimalDigits: 0)
                  .format(state.pemasukanModel.pemasukan.totalKeseluruhan),
              style: textTheme.bodyText1!.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: ColorValue.primaryColor),
            );
          } else if (state is DashboardPageError) {
            return Text(
              "Error",
              style: textTheme.bodyText1!.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: ColorValue.primaryColor),
            );
          } else {
            return Text(
              "Rp. 0",
              style: textTheme.bodyText1!.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: ColorValue.primaryColor),
            );
          }
        },
      ),
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
      items: _months.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(value: value, child: Text(value));
      }).toList(),
    );
  }

  final List<String> _months = [
    "Bulan Ini",
    "3 Bulan Terakhir",
    "6 Bulan Terakhir",
    "1 Tahun Terakhir",
    "Semua",
    "Kustomisasi",
  ];

  Future<void> showDatePickerDialog(BuildContext context, int variableIndex) async {
    //date range picker dialog
    final DateTimeRange? pickedDate = await showDateRangePicker(
        context: context,
        initialDateRange: DateTimeRange(
            start: DateTime.now().subtract(const Duration(days: 7)),
            end: DateTime.now()),
        firstDate: DateTime(2000),
        lastDate: DateTime.now());

    if (pickedDate != null) {
      setState(() {
        switch (variableIndex) {
          case 1:
            selectedDate = pickedDate;
            break;
          case 2:
            selectedDateGrafik = pickedDate;
            break;
          case 3:
            selectedDateAnalisa = pickedDate;
            break;
          default:
            break;
        }
      });
    }
  }

  List<DataPenjualan> getSalesData() {
    List<DataPenjualan> salesDataList = [];

    if (grafikModel != null && grafikModel!.grafikPenjualan != null) {
      for (int i = 0; i < grafikModel!.grafikPenjualan.length; i++) {
        GrafikPenjualan? grafikPenjualan = grafikModel!.grafikPenjualan[i];

        if (grafikPenjualan != null && grafikPenjualan.date != null && grafikPenjualan.total != null) {
          salesDataList.add(
            DataPenjualan(
              grafikPenjualan.date.toString(),
              grafikPenjualan.total.toDouble(),
            ),
          );
        } else {
          salesDataList.add(
            DataPenjualan("Tidak ada Data", 0.0),
          );
        }
      }
    } else {
      salesDataList.add(
        DataPenjualan("Tidak ada Data", 0.0),
      );
    }

    return salesDataList;
  }



}

class DataPenjualan {
  DataPenjualan(this.date, this.total);

  final String date;
  final double total;
}
