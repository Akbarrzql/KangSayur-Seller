import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:kangsayur_seller/ui/widget/card_produk.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../../common/color_value.dart';
import '../../../model/produk_model.dart';

class DaftarProdukPage extends StatefulWidget {
  const DaftarProdukPage({Key? key}) : super(key: key);

  @override
  State<DaftarProdukPage> createState() => _DaftarProdukPageState();
}

class _DaftarProdukPageState extends State<DaftarProdukPage> {

  bool isLoadedBg = false;
  ProdukModel? produkModel;

  Future _produk() async {
    setState(() {
      isLoadedBg = false;
    });

    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('token');

    final responseProduk = await http.get(Uri.parse("https://kangsayur.nitipaja.online/api/seller/produk/display"),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },);

    if (responseProduk.statusCode == 200) {
      produkModel = ProdukModel.fromJson(jsonDecode(responseProduk.body));
      final data = jsonDecode(responseProduk.body);
      setState(() {
        produkModel = ProdukModel.fromJson(data);
      });
    } else {
      print('gagal');
    }

    setState(() {
      isLoadedBg = true;
    });
  }

  String formatRupiah(String? data) {
    return NumberFormat.currency(locale: 'id', symbol: 'Rp ', decimalDigits: 0).format(int.parse(data!));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _produk();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoadedBg ? Center(
        child: Container(
          width: double.infinity,
          child: Align(
            alignment: Alignment.center,
            child: GridView.builder(
              padding: EdgeInsets.all(24),
              itemCount: produkModel!.data.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.7,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (context, index) {
                return CardProduk(
                  hargaProduk: formatRupiah(produkModel!.data[index].hargaProduk.toString()),
                  imageProduk: 'assets/images/wortel.png',
                  namaProduk: produkModel!.data[index].namaProduk.toString(),
                  penjualProduk: produkModel!.data[index].namaToko.toString(),
                );
              },
            ),
          ),
        ),
      ) : const Center(child: CircularProgressIndicator(),),
    );
  }
}
