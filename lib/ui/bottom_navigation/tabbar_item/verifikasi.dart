import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kangsayur_seller/bloc/bloc/verifikasi_bloc.dart';
import 'package:kangsayur_seller/bloc/event/verifikasi_event.dart';
import 'package:kangsayur_seller/bloc/state/verifikasi_state.dart';
import 'package:kangsayur_seller/repository/verifikasi_repository.dart';
import 'package:kangsayur_seller/ui/widget/card_verifikasi.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:shimmer/shimmer.dart';
import '../../../common/color_value.dart';
import '../../../model/verifikasi_model.dart';
import '../../produk/detail_produk.dart';

class VerifikasiPage extends StatefulWidget {
  const VerifikasiPage({Key? key}) : super(key: key);

  @override
  State<VerifikasiPage> createState() => _VerifikasiPageState();
}

class _VerifikasiPageState extends State<VerifikasiPage> {

  String dropdownValueStatus = 'Semua Status';
  String dropdownValueTanggal = 'Semua Tanggal';
  bool isLoadedBg = false;
  VerifikasiModel? verifikasiModel;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body:SingleChildScrollView(
        child: SafeArea(
          child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          width: 150,
                          height: 35,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                              color: ColorValue.neutralColor,
                              width: 1,
                            ),
                          ),
                          child: dropDown_Status(),
                        ),
                        Container(
                          alignment: Alignment.center,
                          width: 150,
                          height: 35,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                              color: ColorValue.neutralColor,
                              width: 1,
                            ),
                          ),
                          child: dropDown_Tanggal(),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24,),
                  BlocProvider(
                    create: (context) => VerifikasiBloc(verifikasiPageRepository: VerifikasiRepository())..add(GetVerifikasi()),
                    child: BlocBuilder<VerifikasiBloc, VerifikasiPageState>(
                      builder: (context, state){
                        if(state is VerifikasiPageLoading){
                          return Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            //child shimmer verifikasi card
                            child: SingleChildScrollView(
                              child: SafeArea(
                                child: Column(
                                  children: [
                                    ListView.builder(
                                      physics: const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: 5,
                                      itemBuilder: (BuildContext context, int index) {
                                        return CardVerifikasi(
                                          jenisVerifikasiProduk: 'Bahan Pokok',
                                          tanggalVerifikasiProduk: 'Tidak tertera Tanggal',
                                          namaVerifikasiProduk: 'Nama Produk',
                                          descVerifikasiProduk: 'Deskripsi Produk',
                                          gambarVerifikasiProduk: 'https://images.unsplash.com/photo-1545830790-68595959c491?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTh8fGZhcm1lcnxlbnwwfHwwfHx8MA%3D%3D&auto=format&fit=crop&w=500&q=60',//'assets/images/wortel.png',
                                          statusVerifikasiProduk: 'Diproses',
                                          onPressed: (){},
                                        );
                                      },
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        }
                        else if (state is VerifikasiPageLoaded){
                          return Center(
                            child: state.verifikasiModel.data.length == 0 ? Center(
                              //lotie loading
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(height: 50,),
                                  Lottie.network("https://assets4.lottiefiles.com/packages/lf20_eogwvdor.json", width: 300, height: 300),
                                  const SizedBox(height: 16),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'Saat ini belum ada produk yang sedang diverifikasi',
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
                            ) : ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: state.verifikasiModel!.data.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return CardVerifikasi(
                                    jenisVerifikasiProduk: 'Bahan Pokok',
                                    tanggalVerifikasiProduk: state.verifikasiModel!.data[index].tanggalVerivikasi == null ? 'Tidak tertera Tanggal' : state.verifikasiModel!.data[index].tanggalVerivikasi.toString(),
                                    namaVerifikasiProduk: state.verifikasiModel!.data[index].namaProduk.toString(),
                                    descVerifikasiProduk: '',
                                    gambarVerifikasiProduk: "https://kangsayur.nitipaja.online${state.verifikasiModel!.data[index].variantImg.toString()}",
                                    statusVerifikasiProduk: state.verifikasiModel!.data[index].status.toString(),
                                    onPressed: (){
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => DetailProduk(
                                            verifikasiModel: state.verifikasiModel!.data[index],
                                            verifikasiModel2: state.verifikasiModel!,
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                            ),
                          );
                        }
                        else if (state is VerifikasiPageError){
                          return Center(
                            child: Text(
                              'Terjadi kesalahan, silahkan coba lagi',
                              style: textTheme.headline6!.copyWith(
                                  color: ColorValue.primaryColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14
                              ),
                            ),
                          );
                        }
                        else{
                          return Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            //child shimmer verifikasi card
                            child: SingleChildScrollView(
                              child: SafeArea(
                                child: Padding(
                                    padding: const EdgeInsets.all(24),
                                    child: Column(
                                      children: [
                                        ListView.builder(
                                          physics: const NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: 5,
                                          itemBuilder: (BuildContext context, int index) {
                                            return CardVerifikasi(
                                              jenisVerifikasiProduk: 'Bahan Pokok',
                                              tanggalVerifikasiProduk: 'Tidak tertera Tanggal',
                                              namaVerifikasiProduk: 'Nama Produk',
                                              descVerifikasiProduk: 'Deskripsi Produk',
                                              gambarVerifikasiProduk: 'assets/images/wortel.png',
                                              statusVerifikasiProduk: 'Diproses',
                                              onPressed: (){},
                                            );
                                          },
                                        )
                                      ],
                                    )
                                ),
                              ),
                            ),
                          );
                        }
                      },
                    ),
                  )
                ],
              )
          ),
        ),
      ),
    );
  }

  Widget dropDown_Status(){
    return DropdownButton<String>(
      value: dropdownValueStatus,
      icon: const Icon(Icons.arrow_drop_down),
      iconSize: 24,
      elevation: 16,
      underline: Container(
        height: 0,
        color: Colors.transparent,
      ),
      style: Theme.of(context).textTheme.subtitle1!.copyWith(
        fontWeight: FontWeight.w400,
        fontSize: 16,
        color: ColorValue.neutralColor,
      ),
      onChanged: (String? newValue) {
        setState(() {
          dropdownValueStatus = newValue!;
        });
      },
      items: <String>['Semua Status', 'Terverifikasi', 'Diproses', 'Ditolak']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
            value: value,
            child: Text(value)
        );
      }).toList(),
    );
  }

  Widget dropDown_Tanggal(){
    return DropdownButton<String>(
      value: dropdownValueTanggal,
      icon: const Icon(Icons.arrow_drop_down),
      iconSize: 24,
      elevation: 16,
      underline: Container(
        height: 0,
        color: Colors.transparent,
      ),
      style: Theme.of(context).textTheme.subtitle1!.copyWith(
        fontWeight: FontWeight.w400,
        fontSize: 16,
        color: ColorValue.neutralColor,
      ),
      onChanged: (String? newValue) {
        setState(() {
          dropdownValueTanggal = newValue!;
        });
      },
      items: <String>[
        'Semua Tanggal',
        'Hari ini',
        'Kemarin',
        '7 Hari Terakhir',
        '30 Hari Terakhir',
        'Bulan ini',
        'Bulan lalu',
        'Tahun ini',
        'Tahun lalu'
      ]
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
            value: value,
            child: Text(value)
        );
      }).toList(),
    );
  }
}
