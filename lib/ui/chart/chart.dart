import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kangsayur_seller/ui/bottom_navigation/item/dashboard.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../common/color_value.dart';

class ChartHorizotalPage extends StatefulWidget {
  const ChartHorizotalPage({Key? key, required this.salesData}) : super(key: key);
  //get data class in file dashboard.dart
  final List<SalesData> salesData;

  @override
  State<ChartHorizotalPage> createState() => _ChartHorizotalPageState();
}

class _ChartHorizotalPageState extends State<ChartHorizotalPage> {

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
        child: Center(
          child: SfCartesianChart(
            enableAxisAnimation: true,
            primaryXAxis: CategoryAxis(),
            // Chart title
            title: ChartTitle(
                text: 'Data Penjualan',
                textStyle: textTheme.bodyText1!.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: ColorValue.neutralColor)),
            zoomPanBehavior: ZoomPanBehavior(
                enablePinching: true,
                enableDoubleTapZooming: true,
                enablePanning: true),
            // Enable legend and show the legend at the bottom
            legend: Legend(
                isVisible: true, position: LegendPosition.bottom),
            // Enable tooltip
            tooltipBehavior: TooltipBehavior(enable: true),
            series: <ChartSeries<SalesData, String>>[
              LineSeries<SalesData, String>(
                  dataSource: widget.salesData,
                  xValueMapper: (SalesData sales, _) => sales.year,
                  yValueMapper: (SalesData sales, _) => sales.sales,
                  color: ColorValue.primaryColor,
                  // Enable data label
                  dataLabelSettings:
                  const DataLabelSettings(isVisible: true))
            ],
          ),
        ),
      ),
    );
  }
}
