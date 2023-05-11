import 'package:flutter/material.dart';
import 'package:kangsayur_seller/ui/transaksi/item_transaksi/ongoing.dart';
import 'package:kangsayur_seller/ui/transaksi/item_transaksi/riwayat.dart';
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
    _tabController = TabController(length: 2, vsync: this); // Jumlah tab sesuai kebutuhan Anda
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
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 50, // Ubah tinggi sesuai kebutuhan Anda
                width: 180,
                child: AppBar(
                  elevation: 0, // Menghilangkan bayangan di bawah AppBar
                  backgroundColor: Colors.transparent, // Menghilangkan background AppBar
                  flexibleSpace: TabBar(
                    unselectedLabelColor: ColorValue.neutralColor, // Warna teks tab yang tidak aktif
                    labelColor: ColorValue.primaryColor, // Warna teks tab yang aktif
                    controller: _tabController,
                    tabs: const [
                      Tab(text: 'Riwayat'),
                      Tab(text: 'Dikirim'),
                    ],
                  ),
                  automaticallyImplyLeading: false,
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    // Widget konten untuk Tab 1
                    RiwayatPage(),
                    // Widget konten untuk Tab 2
                    OngoingPage()
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
