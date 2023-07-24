import 'dart:convert';
import 'dart:io';

import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kangsayur_seller/bloc/bloc/produk_add_bloc.dart';
import 'package:kangsayur_seller/bloc/state/produk_add_state.dart';
import 'package:kangsayur_seller/repository/create_produk_repository.dart';
import 'package:kangsayur_seller/ui/informasi/informasi_tambah_produk.dart';
import 'package:kangsayur_seller/ui/produk/tambah_variant.dart';
import 'package:kangsayur_seller/ui/widget/dialog_alret.dart';
import 'package:kangsayur_seller/ui/widget/main_button.dart';
import 'package:kangsayur_seller/ui/widget/textfiled.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../bloc/event/produk_add_event.dart';
import '../../common/color_value.dart';
import '../bottom_navigation/bottom_navigation.dart';

class TambahProdukPage extends StatefulWidget {
  const TambahProdukPage({Key? key}) : super(key: key);

  @override
  State<TambahProdukPage> createState() => _TambahProdukPageState();
}

class _TambahProdukPageState extends State<TambahProdukPage> {

  bool withInputFormatter = false;
  bool _isKetentuanSelected = false;

  //text controller
  final _namaProdukController = TextEditingController();

  void _tambahVarian() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const TambahVariantPage(),
      ),
    );
    if (result != null && result is Map<String, dynamic>) {
      setState(() {
        _varianList.add(result);
      });
    }
  }

  final List<Kategori> _listKategori = [
    Kategori('Sayuran', false),
    Kategori('Unggas', false),
    Kategori('Bahan Pokok', false),
    Kategori('Buah-Buahan', false),
    Kategori('Daging', false),
    Kategori('Telur', false),
  ];

  final List<String> _katalogIcons = [
    "assets/svg/sayuran_1.svg",
    "assets/svg/unggas.svg",
    "assets/svg/bahan_pokok.svg",
    "assets/svg/buah.svg",
    "assets/svg/daging.svg",
    "assets/svg/telur.svg",
  ];

  final List<Map<String, dynamic>> _varianList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Buat Produk Baru',
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
      body: BlocProvider(
        create: (context) => ProdukAddPageBloc(createProdukRepository: CreateProdukRepository()),
        child: BlocConsumer<ProdukAddPageBloc, ProdukAddState>(
          listener: (context, state) {},
          builder: (context, state){
            if(state is InitialProdukAddState){
              return buildInitialLayout(context);
            } else if(state is ProdukAddLoading){
              return buildLoadingLayout(context);
            } else if(state is ProdukAddLoaded){
              return buildLoadedLayout();
            } else if(state is ProdukAddError){
              print(state.errorMessage);
              return buildErorLayout(context, state.errorMessage);
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        )
      )
    );
  }

  Widget buildInitialLayout(BuildContext context){
    final textTheme = Theme.of(context).textTheme;
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xffD7FEDF),
                borderRadius: BorderRadius.circular(10),
              ),
              height: 50,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.info_outline,
                    color: ColorValue.primaryColor,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Text(
                      "Kamu diharuskan mengisi pada bagian varian produk (harga, stok, dll) minimal 1 varian produk",
                      style: Theme.of(context).textTheme.subtitle1!.copyWith(
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        color: ColorValue.primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Nama Produk",
              style: textTheme.subtitle1!.copyWith(
                fontWeight: FontWeight.w700,
                fontSize: 14,
                color: ColorValue.neutralColor,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            textfield(context, "Masukkan Nama Produk", _namaProdukController, TextInputType.text),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Katalog Produk",
              style: textTheme.subtitle1!.copyWith(
                fontWeight: FontWeight.w700,
                fontSize: 14,
                color: ColorValue.neutralColor,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            GridView.builder(
              shrinkWrap: true,
              itemCount: 6,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 2,
              ),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: (){
                    setState(() {
                      _listKategori[index].isSelected = !_listKategori[index].isSelected;
                    });
                  },
                  child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        color: _listKategori[index].isSelected ? ColorValue.primaryColor : const Color(0xFFB3B3B4),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              _listKategori[index].kategori,
                              style: textTheme.bodyText1!.copyWith(
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                                color: _listKategori[index].isSelected ? Colors.white : Colors.white,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Stack(
                              children: [
                                //circle container white and icon svg
                                Container(
                                  padding: const EdgeInsets.all(2),
                                  height: 42,
                                  width: 42,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: Container(
                                    padding: const EdgeInsets.all(5),
                                    child: SvgPicture.asset(
                                      _katalogIcons[index],
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      )
                  ),
                );
              },
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Varian (Wajib)",
              style: textTheme.subtitle1!.copyWith(
                fontWeight: FontWeight.w700,
                fontSize: 14,
                color: ColorValue.neutralColor,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            if (_varianList.isEmpty)
              ElevatedButton(
                onPressed: _tambahVarian,
                style: ElevatedButton.styleFrom(
                  primary: ColorValue.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                child: Text(
                  "Tambah Varian",
                  style: textTheme.bodyText1!.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    color: Colors.white,
                  ),
                ),
              )
            else
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _varianList.length,
                    itemBuilder: (context, index) {
                      final varian = _varianList[index];
                      return ListTile(
                        title: Text(varian['variant']),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Harga: ${varian['harga_variant']}'),
                            Text('Stok: ${varian['stok']}'),
                          ],
                        ),
                      );
                    },
                  ),
                  ElevatedButton(
                    onPressed: _tambahVarian,
                    style: ElevatedButton.styleFrom(
                      primary: ColorValue.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    child: Text(
                      "Tambah Varian",
                      style: textTheme.bodyText1!.copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            const SizedBox(
              height: 20,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 20,
                  width: 20,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      color: ColorValue.hintColor,
                      width: 0.5,
                    ),
                  ),
                  child: Checkbox(
                    value: _isKetentuanSelected,
                    onChanged: (value) {
                      setState(() {
                        _isKetentuanSelected = value!;
                      });
                    },
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Menyetujui",
                          style: textTheme.bodyText1!.copyWith(
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            color: ColorValue.neutralColor,
                          ),
                        ),
                        const TextSpan(
                          text: " ",
                        ),
                        TextSpan(
                          text: "ketentuan menambah produk",
                          style: textTheme.bodyText1!.copyWith(
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            color: ColorValue.primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            main_button("Tambah Produk", context, onPressed: (){
              if(_isKetentuanSelected){
                BlocProvider.of<ProdukAddPageBloc>(context).add(AddProdukButtonPressed(
                  namaProduk: _namaProdukController.text,
                  kategoriId: _listKategori.indexWhere((element) => element.isSelected),
                  variant: _varianList,
                ));
                print(_varianList);
              }
              else if(_varianList.isEmpty){
                showErrorDialog(context, 'Anda belum menambahkan varian produk', 'Tambah Varian') ;
              }
              else{
                showErrorDialog(context, "Anda belum menyetujui ketentuan menambah produk", "Ketentuan Menambah Produk",);
              }
            })
          ],
        ),
      ),
    );
  }

  Widget buildLoadedLayout(){
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Menunggu Verifikasi',
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
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: SvgPicture.asset(
                  'assets/svg/verifikasi_ilus.svg',
                  width: 250,
                  height: 250,
                ),
              ),
              Text(
                'Barang anda sedang diverifikasi oleh admin',
                style: textTheme.headline6!.copyWith(
                  color: ColorValue.secondaryColor,
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Barang yang kamu tambahkan sedang diverifikasi, tunggu kabar selanjutnya melalui inbox aplikasi ya atau kamu dapat melihat status verifikasi kamu pada bagian produk.',
                textAlign: TextAlign.center,
                style: textTheme.bodyText1!.copyWith(
                  color: ColorValue.neutralColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              main_button("Kembali", context, onPressed: (){
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => const BottomNavigation()),
                        (Route<dynamic> route) => false);
              })
            ],
          ),
        ),
      ),
    );
  }

  Widget buildLoadingLayout(BuildContext context) => const Center(
    child: CircularProgressIndicator(),
  );

  Widget buildErorLayout(BuildContext context, String message){
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            message,
            style: Theme.of(context).textTheme.headline6!.copyWith(
              color: ColorValue.secondaryColor,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              primary: ColorValue.primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            child: const Text("Kembali"),
          ),
        ],
      ),
    );
  }

}

class Kategori {
  final String kategori;
  bool isSelected;

  Kategori(this.kategori, this.isSelected);
}