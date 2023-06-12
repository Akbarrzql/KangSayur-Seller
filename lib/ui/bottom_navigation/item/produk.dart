import 'package:flutter/material.dart';
import 'package:kangsayur_seller/common/color_value.dart';
import 'package:kangsayur_seller/ui/bottom_navigation/tabbar_item/daftar_produk.dart';
import 'package:kangsayur_seller/ui/bottom_navigation/tabbar_item/verifikasi.dart';
import 'package:kangsayur_seller/ui/produk/tambah_produk.dart';

class ProdukPage extends StatefulWidget {
  const ProdukPage({Key? key}) : super(key: key);

  @override
  State<ProdukPage> createState() => _ProdukPageState();
}

class _ProdukPageState extends State<ProdukPage>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
        length: 2, vsync: this); // Jumlah tab sesuai kebutuhan Anda
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 50, // Ubah tinggi sesuai kebutuhan Anda
              child: AppBar(
                elevation: 0,
                // Menghilangkan bayangan di bawah AppBar
                backgroundColor: Colors.white,
                // Menghilangkan background AppBar
                flexibleSpace: TabBar(
                  unselectedLabelColor: ColorValue.neutralColor,
                  // Warna teks tab yang tidak aktif
                  labelColor: ColorValue.primaryColor,
                  // Warna teks tab yang aktif
                  controller: _tabController,
                  tabs: const [
                    Tab(text: 'Daftar Produk'),
                    Tab(text: 'Verifikasi'),
                  ],
                ),
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  // Widget konten untuk Tab 1
                  DaftarProdukPage(),
                  // Widget konten untuk Tab 2
                  VerifikasiPage()
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Aksi ketika FAB ditekan
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const TambahProdukPage()));
        },
        child: Icon(Icons.add),
        backgroundColor: ColorValue.primaryColor,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
