import 'package:flutter/material.dart';
import 'package:kangsayur_seller/ui/transaksi/item_transaksi/confim_driver.dart';
import 'package:kangsayur_seller/ui/transaksi/item_transaksi/dikirim.dart';
import 'package:kangsayur_seller/ui/transaksi/item_transaksi/disiapkan.dart';
import 'package:kangsayur_seller/ui/transaksi/item_transaksi/pesanan.dart';
import 'package:kangsayur_seller/ui/transaksi/item_transaksi/selesai_riwayat.dart';
import '../../common/color_value.dart';

class TranskasiPage extends StatefulWidget {
  const TranskasiPage({Key? key}) : super(key: key);

  @override
  State<TranskasiPage> createState() => _TranskasiPageState();
}

class _TranskasiPageState extends State<TranskasiPage> with SingleTickerProviderStateMixin {

  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this); // Jumlah tab sesuai kebutuhan Anda
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Transaksi',
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
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 50, // Ubah tinggi sesuai kebutuhan Anda
                child: AppBar(
                  elevation: 0, // Menghilangkan bayangan di bawah AppBar
                  backgroundColor: Colors.transparent, // Menghilangkan background AppBar
                  //scrollabe tabbar with controller
                  bottom: TabBar(
                    controller: _tabController,
                    isScrollable: true,
                    indicatorColor: ColorValue.primaryColor,
                    indicatorWeight: 2,
                    labelColor: ColorValue.primaryColor,
                    unselectedLabelColor: ColorValue.neutralColor,
                    labelStyle: textTheme.bodyText1!.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                    unselectedLabelStyle: textTheme.bodyText1!.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                    tabs: const [
                      Tab(text: 'Pesanan'),
                      Tab(text: 'Disiapkan'),
                      Tab(text: 'Menunggu Driver'),
                      Tab(text: 'Dikirim'),
                      Tab(text: 'Selesai'),
                    ],
                  ),
                  automaticallyImplyLeading: false,
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: const [
                    PesananPage(),
                    DisiapkanPage(),
                    ConfirmDriver(),
                    OngoingPage(),
                    RiwayatPage(),
                  ],
                ),
              ),
            ],
          ),
        )
      ),
    );
  }
}
