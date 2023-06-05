import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:kangsayur_seller/ui/widget/card_produk.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:shimmer/shimmer.dart';
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
  TextEditingController controllersearch = TextEditingController();
  List<Datum> filteredProdukModel = [];
  int selectedProdukIndex = 0;

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
        filteredProdukModel = produkModel!.data;
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

  void _filterProduk(String keyword) {
    setState(() {
      if (keyword.isNotEmpty) {
        filteredProdukModel = produkModel!.data.where((produk) {
          final namaProduk = produk.namaProduk.toString().toLowerCase();
          return namaProduk.contains(keyword.toLowerCase());
        }).toList();
      } else {
        filteredProdukModel = produkModel!.data;
      }

      // Reset selected index
      selectedProdukIndex = 0;
    });
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
        child: Column(
          children: [
            //search outline
            Container(
              margin: const EdgeInsets.only(top: 24, left: 24, right: 24),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                border: Border.all(
                  color: ColorValue.hintColor,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      onChanged : _filterProduk,
                      controller: controllersearch,
                      decoration: const InputDecoration(
                        hintText: 'Cari Produk...',
                        hintStyle: TextStyle(
                          color: ColorValue.hintColor,
                          fontSize: 14,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            //list produk
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(24),
                itemCount: filteredProdukModel.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.7,
                  mainAxisSpacing: 10,
                ),
                itemBuilder: (context, index) {
                  return CardProduk(
                    hargaProduk: formatRupiah(filteredProdukModel[index].hargaProduk.toString()),
                    imageProduk: 'assets/images/wortel.png',
                    namaProduk: filteredProdukModel[index].namaProduk,
                    penjualProduk: filteredProdukModel[index].namaToko,
                    isSelected: index == selectedProdukIndex,
                  );
                },
              ),
            ),
          ],
        ),
      ) : Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        //shimmer child widget produk
        child: Column(
          children: [
            //search outline
            Container(
              margin: const EdgeInsets.only(top: 24, left: 24, right: 24),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                border: Border.all(
                  color: ColorValue.hintColor,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      onChanged : _filterProduk,
                      controller: controllersearch,
                      decoration: const InputDecoration(
                        hintText: 'Cari Produk...',
                        hintStyle: TextStyle(
                          color: ColorValue.hintColor,
                          fontSize: 14,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            //list produk
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(24),
                itemCount: 6,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.7,
                  mainAxisSpacing: 10,
                ),
                itemBuilder: (context, index) {
                  return CardProduk(
                    hargaProduk: '',
                    imageProduk: 'assets/images/wortel.png',
                    namaProduk: '',
                    penjualProduk: '',
                    isSelected: index == selectedProdukIndex,
                  );
                },
              ),
            ),
          ],
        )
      ),
    );
  }
}
