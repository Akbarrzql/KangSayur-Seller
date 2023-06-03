import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kangsayur_seller/ui/widget/card_verifikasi.dart';

import '../../../common/color_value.dart';
import '../../produk/detail_produk.dart';

class VerifikasiPage extends StatefulWidget {
  const VerifikasiPage({Key? key}) : super(key: key);

  @override
  State<VerifikasiPage> createState() => _VerifikasiPageState();
}

class _VerifikasiPageState extends State<VerifikasiPage> {

  String dropdownValueStatus = 'Semua Status';
  String dropdownValueTanggal = 'Semua Tanggal';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                Row(
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
                const SizedBox(height: 24,),
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 3  ,
                  itemBuilder: (BuildContext context, int index) {
                    return CardVerifikasi(
                      jenisVerifikasiProduk: 'Bahan Pokok',
                      tanggalVerifikasiProduk: '12/12/2021',
                      namaVerifikasiProduk: 'Wortel',
                      descVerifikasiProduk: 'Wortel segar dari kebun sayur',
                      gambarVerifikasiProduk: 'assets/images/wortel.png',
                      statusVerifikasiProduk: 'Terverifikasi',
                      onPressed: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const DetailProduk(),
                          ),
                        );
                      },
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
