import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:kangsayur_seller/bloc/bloc/produk_bloc.dart';
import 'package:kangsayur_seller/bloc/bloc/profile_bloc.dart';
import 'package:kangsayur_seller/bloc/state/produk_state.dart';
import 'package:kangsayur_seller/repository/produk_repository.dart';
import 'package:kangsayur_seller/ui/widget/card_produk.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:shimmer/shimmer.dart';
import '../../../bloc/event/produk_event.dart';
import '../../../common/color_value.dart';
import '../../../model/produk_model.dart';

class DaftarProdukPage extends StatefulWidget {
  const DaftarProdukPage({Key? key}) : super(key: key);

  @override
  State<DaftarProdukPage> createState() => _DaftarProdukPageState();
}

class _DaftarProdukPageState extends State<DaftarProdukPage> {

  bool isLoadedBg = false;
  bool produkLoaded = false;
  ProdukModel? produkModel;
  TextEditingController controllersearch = TextEditingController();
  List<Datum> filteredProdukModel = [];
  int selectedProdukIndex = 0;


  String formatRupiah(String? data) {
    return NumberFormat.currency(locale: 'id', symbol: 'Rp ', decimalDigits: 0).format(int.parse(data!));
  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: BlocProvider(
        create: (context) => ProdukPageBloc(produkPageRepository: ProdukRepository())..add(GetProduk()),
        child: BlocBuilder<ProdukPageBloc, ProdukPageState>(
          builder: (context, state){
            if(state is ProdukPageLoading) {
              return Shimmer.fromColors(
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
              );
            }
            else if (state is ProdukPageLoaded) {
              produkModel = state.produkModel;
              filteredProdukModel = produkModel!.data;
              return Center(
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
                              onChanged: (value) {
                                context.read<ProdukPageBloc>().add(FilterProduk(value));
                              },
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
                        child: filteredProdukModel.isEmpty ? Center(
                          //lotie loading
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Lottie.network("https://assets2.lottiefiles.com/packages/lf20_md6cjjSl1R.json", height: 200, width: 200),
                              const SizedBox(height: 16),
                              Padding(
                                padding: const EdgeInsets.all(24.0),
                                child: Text(
                                  'Jutaan mimpi dimulai dari satu langkah pertama. Yuk tambah produk pertamamu sekarang!',
                                  textAlign: TextAlign.center,
                                  style: textTheme.headline6!.copyWith(
                                      color: ColorValue.primaryColor,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14
                                  ),
                                ),
                              )
                            ],
                          ),
                        ) : GridView.builder(
                          padding: const EdgeInsets.all(24),
                          itemCount: filteredProdukModel.length,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.7,
                            mainAxisSpacing: 10,
                          ),
                          itemBuilder: (context, index) {
                            return CardProduk(
                              hargaProduk: formatRupiah(filteredProdukModel[index].hargaVariant.toString()),
                              imageProduk: 'assets/images/wortel.png',
                              namaProduk: filteredProdukModel[index].namaProduk,
                              penjualProduk: filteredProdukModel[index].status,
                              isSelected: index == selectedProdukIndex,
                            );
                          },
                        )
                    ),
                  ],
                ),
              );
            }
            else if (state is ProdukPageFiltered){
              filteredProdukModel = state.filteredProdukModel;
              return Center(
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
                              onChanged: (value) {
                                context.read<ProdukPageBloc>().add(FilterProduk(value));
                              },
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
                        child: filteredProdukModel.isEmpty ? Center(
                          //lotie loading
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Lottie.network("https://assets2.lottiefiles.com/packages/lf20_md6cjjSl1R.json", height: 200, width: 200),
                              const SizedBox(height: 16),
                              Padding(
                                padding: const EdgeInsets.all(24.0),
                                child: Text(
                                  'Jutaan mimpi dimulai dari satu langkah pertama. Yuk tambah produk pertamamu sekarang!',
                                  textAlign: TextAlign.center,
                                  style: textTheme.headline6!.copyWith(
                                      color: ColorValue.primaryColor,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14
                                  ),
                                ),
                              )
                            ],
                          ),
                        ) : GridView.builder(
                          padding: const EdgeInsets.all(24),
                          itemCount: filteredProdukModel.length,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.7,
                            mainAxisSpacing: 10,
                          ),
                          itemBuilder: (context, index) {
                            return CardProduk(
                              hargaProduk: formatRupiah(filteredProdukModel[index].hargaVariant.toString()),
                              imageProduk: 'assets/images/wortel.png',
                              namaProduk: filteredProdukModel[index].namaProduk,
                              penjualProduk: filteredProdukModel[index].status.toString(),
                              isSelected: index == selectedProdukIndex,
                            );
                          },
                        )
                    ),
                  ],
                ),
              );
            }
            else if (state is ProdukPageError) {
              return Text(
                "Kesalahan dalam mengambil data",
                style: textTheme.bodyText1!.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: ColorValue.neutralColor),
              );
            }
            else{
              return Shimmer.fromColors(
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
              );
            }
          },
        ),
      ),
    );
  }
}
