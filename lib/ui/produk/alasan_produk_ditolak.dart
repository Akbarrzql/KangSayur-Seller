import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kangsayur_seller/model/verifikasi_model.dart';
import 'package:kangsayur_seller/ui/widget/main_button.dart';

import '../../common/color_value.dart';
import 'detail_produk.dart';

class AlasanDitolakPage extends StatefulWidget {
  const AlasanDitolakPage({Key? key, required this.data}) : super(key: key);
  final Datum? data;

  @override
  State<AlasanDitolakPage> createState() => _AlasanDitolakPageState();
}

class _AlasanDitolakPageState extends State<AlasanDitolakPage> {

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Alasan Produk Ditolak',
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
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Mengapa produk saya ditolak?",
                style: textTheme.headline6!.copyWith(
                  color: ColorValue.neutralColor,
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Center(
                child: SvgPicture.asset(
                  'assets/svg/ilus_ditolak.svg',
                  width: 200,
                  height: 200,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                "Ketika melakukan verifikasi produk di marketplace, produk Anda harus memenuhi persyaratan dan standar yang telah ditetapkan oleh marketplace tersebut. Jika produk Anda ditolak, biasanya ada beberapa alasan di balik penolakan tersebut. \n \nSalah satu alasan yang paling umum adalah pelanggaran kebijakan marketplace. Misalnya, jika produk Anda melanggar hukum atau peraturan tertentu, seperti produk ilegal atau produk yang melanggar hak kekayaan intelektual, maka produk Anda tidak akan disetujui. Pastikan untuk mengetahui dan memahami kebijakan dan peraturan marketplace terkait sebelum memasukkan produk Anda untuk verifikasi. \n \nSelain itu, deskripsi produk yang tidak jelas atau tidak lengkap juga dapat menjadi alasan penolakan. Pastikan deskripsi produk yang Anda berikan lengkap, jelas, dan sesuai dengan standar marketplace. Hal ini akan memudahkan calon pembeli untuk memahami produk Anda dan membuat mereka lebih percaya untuk membeli produk Anda. \n \nFoto produk yang buruk juga dapat menyebabkan penolakan. Pastikan bahwa foto produk yang Anda berikan berkualitas tinggi dan memenuhi standar marketplace terkait. Foto yang buram atau tidak jelas dapat membuat calon pembeli kehilangan minat pada produk Anda. \n \nHarga produk yang tidak realistis juga dapat menyebabkan penolakan. Pastikan bahwa harga produk Anda sesuai dengan pasar dan kompetitif dibandingkan dengan produk serupa di marketplace lainnya. Harga yang terlalu tinggi atau terlalu rendah dibandingkan dengan produk serupa di marketplace lainnya dapat membuat calon pembeli meragukan produk Anda. \n \nTerakhir, produk yang rusak atau cacat juga dapat menjadi alasan penolakan. Pastikan produk yang Anda pasarkan dalam kondisi baik dan memenuhi standar marketplace. Jika produk Anda rusak, cacat, atau tidak sesuai dengan deskripsi yang diberikan, maka calon pembeli akan merasa kecewa dan dapat mempengaruhi reputasi bisnis Anda. \n \nOleh karena itu, pastikan produk Anda memenuhi semua persyaratan yang ditetapkan oleh marketplace dan sesuai dengan kebijakan dan standar yang berlaku agar tidak ditolak saat verifikasi.",
                style: textTheme.bodyText1!.copyWith(
                  color: ColorValue.neutralColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(
                height: 24,
              ),
              main_button("Kembali", context, onPressed: (){
               Navigator.pop(context);
              })
            ],
          ),
        )
      )
    );
  }
}
