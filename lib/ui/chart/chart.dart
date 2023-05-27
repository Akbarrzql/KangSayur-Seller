import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kangsayur_seller/ui/bottom_navigation/item/dashboard.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../common/color_value.dart';

class ChartHorizotalPage extends StatefulWidget {
  const ChartHorizotalPage({Key? key, required this.salesData, required this.salesDataDateList}) : super(key: key);
  final List<SalesData> salesData;
  final List<SalesData> salesDataDateList;

  @override
  State<ChartHorizotalPage> createState() => _ChartHorizotalPageState();
}

class _ChartHorizotalPageState extends State<ChartHorizotalPage> {

  String _selectedMonthGrafik = 'Bulan Ini';
  DateTimeRange? selectedDate;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //orientation
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  @override
  void dispose() {
    // Reset preferred orientation
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Data Penjualan',
                    style: textTheme.headline6!.copyWith(
                      color: ColorValue.neutralColor,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  DropdownGrafik(),
                ],
              ),
              if(_selectedMonthGrafik == 'Bulan Ini')
                Center(
                  child: SfCartesianChart(
                    enableAxisAnimation: true,
                    primaryXAxis: CategoryAxis(),
                    zoomPanBehavior: ZoomPanBehavior(
                        enablePinching: true,
                        enableDoubleTapZooming: true,
                        enablePanning: true),
                    // Enable legend and show the legend at the bottom
                    legend: Legend(
                      isVisible: true,
                      position: LegendPosition.right,
                      overflowMode: LegendItemOverflowMode.wrap,
                      toggleSeriesVisibility: false,
                      legendItemBuilder: (String name, dynamic series, dynamic point, int index) {
                        List<String> daysOfWeek = ['Senin', 'Selasa', 'Rabu', 'Kamis', 'Jumat', 'Sabtu', 'Minggu'];
                        SalesData data = widget.salesData[index];
                        return Container(
                          width: 100,
                          height: 37,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${daysOfWeek[index]}:',
                                style: textTheme.bodyText1!.copyWith(
                                  color: ColorValue.neutralColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(width: 4),
                              Text(
                                '${data.sales}',
                                style: textTheme.bodyText1!.copyWith(
                                  color: ColorValue.primaryColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    // Enable tooltip
                    tooltipBehavior: TooltipBehavior(
                      enable: true,
                      header: 'Penjualan',
                    ),
                    series: <ChartSeries<SalesData, String>>[
                      LineSeries<SalesData, String>(
                        dataSource: widget.salesData,
                        xValueMapper: (SalesData sales, _) => sales.year,
                        yValueMapper: (SalesData sales, _) => sales.sales,
                        color: ColorValue.primaryColor,
                        // Enable data label
                        dataLabelSettings:
                        const DataLabelSettings(isVisible: true),
                        name: 'Senin',
                        markerSettings: const MarkerSettings(
                          isVisible: true,
                          shape: DataMarkerType.circle,
                          borderWidth: 2,
                          borderColor: ColorValue.primaryColor,
                          color: ColorValue.primaryColor,
                        ),
                      ),
                      LineSeries<SalesData, String>(
                        dataSource: widget.salesData,
                        xValueMapper: (SalesData sales, _) => sales.year,
                        yValueMapper: (SalesData sales, _) => sales.sales,
                        color: ColorValue.primaryColor,
                        // Enable data label
                        dataLabelSettings:
                        const DataLabelSettings(isVisible: true),
                        name: 'Senin',
                        markerSettings: const MarkerSettings(
                          isVisible: true,
                          shape: DataMarkerType.circle,
                          borderWidth: 2,
                          borderColor: ColorValue.primaryColor,
                          color: ColorValue.primaryColor,
                        ),
                      ),
                      LineSeries<SalesData, String>(
                        dataSource: widget.salesData,
                        xValueMapper: (SalesData sales, _) => sales.year,
                        yValueMapper: (SalesData sales, _) => sales.sales,
                        color: ColorValue.primaryColor,
                        // Enable data label
                        dataLabelSettings:
                        const DataLabelSettings(isVisible: true),
                        name: 'Rabu',
                        markerSettings: const MarkerSettings(
                          isVisible: true,
                          shape: DataMarkerType.circle,
                          borderWidth: 2,
                          borderColor: ColorValue.primaryColor,
                          color: ColorValue.primaryColor,
                        ),
                      ),
                      LineSeries<SalesData, String>(
                        dataSource: widget.salesData,
                        xValueMapper: (SalesData sales, _) => sales.year,
                        yValueMapper: (SalesData sales, _) => sales.sales,
                        color: ColorValue.primaryColor,
                        // Enable data label
                        dataLabelSettings:
                        const DataLabelSettings(isVisible: true),
                        name: 'Kamis',
                        markerSettings: const MarkerSettings(
                          isVisible: true,
                          shape: DataMarkerType.circle,
                          borderWidth: 2,
                          borderColor: ColorValue.primaryColor,
                          color: ColorValue.primaryColor,
                        ),
                      ),
                      LineSeries<SalesData, String>(
                        dataSource: widget.salesData,
                        xValueMapper: (SalesData sales, _) => sales.year,
                        yValueMapper: (SalesData sales, _) => sales.sales,
                        color: ColorValue.primaryColor,
                        // Enable data label
                        dataLabelSettings:
                        const DataLabelSettings(isVisible: true),
                        name: 'Jumat',
                        markerSettings: const MarkerSettings(
                          isVisible: true,
                          shape: DataMarkerType.circle,
                          borderWidth: 2,
                          borderColor: ColorValue.primaryColor,
                          color: ColorValue.primaryColor,
                        ),
                      ),
                      LineSeries<SalesData, String>(
                        dataSource: widget.salesData,
                        xValueMapper: (SalesData sales, _) => sales.year,
                        yValueMapper: (SalesData sales, _) => sales.sales,
                        color: ColorValue.primaryColor,
                        // Enable data label
                        dataLabelSettings:
                        const DataLabelSettings(isVisible: true),
                        name: 'Sabtu',
                        markerSettings: const MarkerSettings(
                          isVisible: true,
                          shape: DataMarkerType.circle,
                          borderWidth: 2,
                          borderColor: ColorValue.primaryColor,
                          color: ColorValue.primaryColor,
                        ),
                      ),
                      LineSeries<SalesData, String>(
                        dataSource: widget.salesData,
                        xValueMapper: (SalesData sales, _) => sales.year,
                        yValueMapper: (SalesData sales, _) => sales.sales,
                        color: ColorValue.primaryColor,
                        // Enable data label
                        dataLabelSettings:
                        const DataLabelSettings(isVisible: true),
                        name: 'Minggu',
                        markerSettings: const MarkerSettings(
                          isVisible: true,
                          shape: DataMarkerType.circle,
                          borderWidth: 2,
                          borderColor: ColorValue.primaryColor,
                          color: ColorValue.primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              if (_selectedMonthGrafik == 'Kustomisasi')
                if(selectedDate != null)
                  Center(
                    child: SfCartesianChart(
                      enableAxisAnimation: true,
                      primaryXAxis: CategoryAxis(),
                      zoomPanBehavior: ZoomPanBehavior(
                          enablePinching: true,
                          enableDoubleTapZooming: true,
                          enablePanning: true),
                      // Enable legend and show the legend at the bottom
                      legend: Legend(
                        isVisible: true,
                        position: LegendPosition.right,
                        overflowMode: LegendItemOverflowMode.wrap,
                        alignment: ChartAlignment.center,
                        toggleSeriesVisibility: false,
                        legendItemBuilder: (String name, dynamic series, dynamic point, int index) {
                          List<String> daysOfWeek = ['Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni', 'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember'];
                          SalesData data = widget.salesDataDateList[index];
                          return Container(
                            width: 150,
                            height: 30,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  '${daysOfWeek[index]}:',
                                  style: textTheme.bodyText1!.copyWith(
                                    color: ColorValue.neutralColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(width: 4),
                                Text(
                                  '${data.sales}',
                                  style: textTheme.bodyText1!.copyWith(
                                    color: ColorValue.primaryColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      // Enable tooltip
                      tooltipBehavior: TooltipBehavior(
                        enable: true,
                        header: 'Penjualan',
                      ),
                      series: <ChartSeries<SalesData, String>>[
                        LineSeries<SalesData, String>(
                          dataSource: widget.salesDataDateList,
                          xValueMapper: (SalesData sales, _) => sales.year,
                          yValueMapper: (SalesData sales, _) => sales.sales,
                          color: ColorValue.primaryColor,
                          // Enable data label
                          dataLabelSettings:
                          const DataLabelSettings(isVisible: true),
                          name: 'Januari',
                          markerSettings: const MarkerSettings(
                            isVisible: true,
                            shape: DataMarkerType.circle,
                            borderWidth: 2,
                            borderColor: ColorValue.primaryColor,
                            color: ColorValue.primaryColor,
                          ),
                        ),
                        LineSeries<SalesData, String>(
                          dataSource: widget.salesDataDateList,
                          xValueMapper: (SalesData sales, _) => sales.year,
                          yValueMapper: (SalesData sales, _) => sales.sales,
                          color: ColorValue.primaryColor,
                          // Enable data label
                          dataLabelSettings:
                          const DataLabelSettings(isVisible: true),
                          name: 'Febuari',
                          markerSettings: const MarkerSettings(
                            isVisible: true,
                            shape: DataMarkerType.circle,
                            borderWidth: 2,
                            borderColor: ColorValue.primaryColor,
                            color: ColorValue.primaryColor,
                          ),
                        ),
                        LineSeries<SalesData, String>(
                          dataSource: widget.salesDataDateList,
                          xValueMapper: (SalesData sales, _) => sales.year,
                          yValueMapper: (SalesData sales, _) => sales.sales,
                          color: ColorValue.primaryColor,
                          // Enable data label
                          dataLabelSettings:
                          const DataLabelSettings(isVisible: true),
                          name: 'Maret',
                          markerSettings: const MarkerSettings(
                            isVisible: true,
                            shape: DataMarkerType.circle,
                            borderWidth: 2,
                            borderColor: ColorValue.primaryColor,
                            color: ColorValue.primaryColor,
                          ),
                        ),
                        LineSeries<SalesData, String>(
                          dataSource: widget.salesDataDateList,
                          xValueMapper: (SalesData sales, _) => sales.year,
                          yValueMapper: (SalesData sales, _) => sales.sales,
                          color: ColorValue.primaryColor,
                          // Enable data label
                          dataLabelSettings:
                          const DataLabelSettings(isVisible: true),
                          name: 'April',
                          markerSettings: const MarkerSettings(
                            isVisible: true,
                            shape: DataMarkerType.circle,
                            borderWidth: 2,
                            borderColor: ColorValue.primaryColor,
                            color: ColorValue.primaryColor,
                          ),
                        ),
                        LineSeries<SalesData, String>(
                          dataSource: widget.salesDataDateList,
                          xValueMapper: (SalesData sales, _) => sales.year,
                          yValueMapper: (SalesData sales, _) => sales.sales,
                          color: ColorValue.primaryColor,
                          // Enable data label
                          dataLabelSettings:
                          const DataLabelSettings(isVisible: true),
                          name: 'Mei',
                          markerSettings: const MarkerSettings(
                            isVisible: true,
                            shape: DataMarkerType.circle,
                            borderWidth: 2,
                            borderColor: ColorValue.primaryColor,
                            color: ColorValue.primaryColor,
                          ),
                        ),
                        LineSeries<SalesData, String>(
                          dataSource: widget.salesDataDateList,
                          xValueMapper: (SalesData sales, _) => sales.year,
                          yValueMapper: (SalesData sales, _) => sales.sales,
                          color: ColorValue.primaryColor,
                          // Enable data label
                          dataLabelSettings:
                          const DataLabelSettings(isVisible: true),
                          name: 'Juni',
                          markerSettings: const MarkerSettings(
                            isVisible: true,
                            shape: DataMarkerType.circle,
                            borderWidth: 2,
                            borderColor: ColorValue.primaryColor,
                            color: ColorValue.primaryColor,
                          ),
                        ),
                        LineSeries<SalesData, String>(
                          dataSource: widget.salesDataDateList,
                          xValueMapper: (SalesData sales, _) => sales.year,
                          yValueMapper: (SalesData sales, _) => sales.sales,
                          color: ColorValue.primaryColor,
                          // Enable data label
                          dataLabelSettings:
                          const DataLabelSettings(isVisible: true),
                          name: 'Juli',
                          markerSettings: const MarkerSettings(
                            isVisible: true,
                            shape: DataMarkerType.circle,
                            borderWidth: 2,
                            borderColor: ColorValue.primaryColor,
                            color: ColorValue.primaryColor,
                          ),
                        ),
                        LineSeries<SalesData, String>(
                          dataSource: widget.salesDataDateList,
                          xValueMapper: (SalesData sales, _) => sales.year,
                          yValueMapper: (SalesData sales, _) => sales.sales,
                          color: ColorValue.primaryColor,
                          // Enable data label
                          dataLabelSettings:
                          const DataLabelSettings(isVisible: true),
                          name: 'Agustus',
                          markerSettings: const MarkerSettings(
                            isVisible: true,
                            shape: DataMarkerType.circle,
                            borderWidth: 2,
                            borderColor: ColorValue.primaryColor,
                            color: ColorValue.primaryColor,
                          ),
                        ),
                        LineSeries<SalesData, String>(
                          dataSource: widget.salesDataDateList,
                          xValueMapper: (SalesData sales, _) => sales.year,
                          yValueMapper: (SalesData sales, _) => sales.sales,
                          color: ColorValue.primaryColor,
                          // Enable data label
                          dataLabelSettings:
                          const DataLabelSettings(isVisible: true),
                          name: 'September',
                          markerSettings: const MarkerSettings(
                            isVisible: true,
                            shape: DataMarkerType.circle,
                            borderWidth: 2,
                            borderColor: ColorValue.primaryColor,
                            color: ColorValue.primaryColor,
                          ),
                        ),
                        LineSeries<SalesData, String>(
                          dataSource: widget.salesDataDateList,
                          xValueMapper: (SalesData sales, _) => sales.year,
                          yValueMapper: (SalesData sales, _) => sales.sales,
                          color: ColorValue.primaryColor,
                          // Enable data label
                          dataLabelSettings:
                          const DataLabelSettings(isVisible: true),
                          name: 'Oktober',
                          markerSettings: const MarkerSettings(
                            isVisible: true,
                            shape: DataMarkerType.circle,
                            borderWidth: 2,
                            borderColor: ColorValue.primaryColor,
                            color: ColorValue.primaryColor,
                          ),
                        ),
                        LineSeries<SalesData, String>(
                          dataSource: widget.salesDataDateList,
                          xValueMapper: (SalesData sales, _) => sales.year,
                          yValueMapper: (SalesData sales, _) => sales.sales,
                          color: ColorValue.primaryColor,
                          // Enable data label
                          dataLabelSettings:
                          const DataLabelSettings(isVisible: true),
                          name: 'November',
                          markerSettings: const MarkerSettings(
                            isVisible: true,
                            shape: DataMarkerType.circle,
                            borderWidth: 2,
                            borderColor: ColorValue.primaryColor,
                            color: ColorValue.primaryColor,
                          ),
                        ),
                        LineSeries<SalesData, String>(
                          dataSource: widget.salesDataDateList,
                          xValueMapper: (SalesData sales, _) => sales.year,
                          yValueMapper: (SalesData sales, _) => sales.sales,
                          color: ColorValue.primaryColor,
                          // Enable data label
                          dataLabelSettings:
                          const DataLabelSettings(isVisible: true),
                          name: 'Desember',
                          markerSettings: const MarkerSettings(
                            isVisible: true,
                            shape: DataMarkerType.circle,
                            borderWidth: 2,
                            borderColor: ColorValue.primaryColor,
                            color: ColorValue.primaryColor,
                          ),
                        ),
                      ],
                    ),
                  )
              else
                  ElevatedButton(
                    onPressed: () => showDatePickerDialog(context),
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
            ],
          ),
        )
      ),
    );
  }

  Widget DropdownGrafik() {
    return DropdownButton<String>(
      value: _selectedMonthGrafik,
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
          _selectedMonthGrafik = newValue!;
        });
      },
      items: _months.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(value: value, child: Text(value));
      }).toList(),
      onTap: () {
        _selectedMonthGrafik = _selectedMonthGrafik;
        if (_selectedMonthGrafik == "Kustomisasi") {
          showDatePickerDialog(context);
        } else {
          selectedDate = null;
        }
      },
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

  Future<void> showDatePickerDialog(BuildContext context) async {
    //date range picker dialog
    final DateTimeRange? pickedDate = await showDateRangePicker(
        context: context,
        initialDateRange: DateTimeRange(
            start: DateTime.now().subtract(const Duration(days: 7)),
            end: DateTime.now()),
        firstDate: DateTime(2000),
        lastDate: DateTime.now());

    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }
}
