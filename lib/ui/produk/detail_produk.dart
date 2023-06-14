import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kangsayur_seller/model/verifikasi_model.dart';
import 'package:kangsayur_seller/ui/widget/main_button.dart';
import '../../common/color_value.dart';
import 'alasan_produk_ditolak.dart';
import 'package:intl/intl.dart';

class DetailProduk extends StatefulWidget {
  const DetailProduk({Key? key, required this.verifikasiModel}) : super(key: key);
  final Datum verifikasiModel;

  @override
  State<DetailProduk> createState() => _DetailProdukState();
}

class _DetailProdukState extends State<DetailProduk> {

  String formatRupiah(String? data) {
    return NumberFormat.currency(locale: 'id', symbol: 'Rp ', decimalDigits: 0).format(int.parse(data!));
  }
  
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Detail Produk',
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 24, 24, 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SvgPicture.asset(
                          'assets/svg/bahan_pokok.svg',
                          width: 45,
                          height: 45,
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Bahan Pokok',
                              style: textTheme.headline6!.copyWith(
                                color: ColorValue.neutralColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Text(
                              widget.verifikasiModel.tanggalVerivikasi == null ? "Tidak tertera Tanggal" : widget.verifikasiModel.tanggalVerivikasi.toString(),
                              style: textTheme.headline6!.copyWith(
                                color: ColorValue.hintColor,
                                fontSize: 10,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    Container(
                      alignment: Alignment.center,
                      height: 30,
                      width: 120,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: widget.verifikasiModel.status == "Pending" ? const Color(0xFFFDF2B2) : widget.verifikasiModel.status == "Ditolak" ? const Color(0xFFFFEAEF) : const Color(0xFFD7FEDF)
                      ),
                      child: Text(
                        widget.verifikasiModel.status == "Pending" ? "Diproses" : widget.verifikasiModel.status == "Rejected" ? "Ditolak" : "Terverifikasi",
                        style: Theme.of(context).textTheme.subtitle1!.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: widget.verifikasiModel.status == "Pending" ? const Color(0xFFEB6D18) : widget.verifikasiModel.status == "Rejected" ? const Color(0xFFD6001C) : ColorValue.primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: ColorValue.hintColor,
                      width: 1.5,
                    ),
                  ),
                ),
                child: Image.asset(
                  "assets/images/wortel.png",
                  height: 265,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.fromLTRB(24,0, 24, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.verifikasiModel.namaProduk == null ? "Tidak tertera Nama Produk" : widget.verifikasiModel.namaProduk.toString(),
                      style: textTheme.headline6!.copyWith(
                        color: ColorValue.neutralColor,
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 5,),
                    Text(
                      widget.verifikasiModel.hargaVariant == null ? "Tidak tertera Harga" : formatRupiah(widget.verifikasiModel.hargaVariant.toString()),
                      style: textTheme.headline6!.copyWith(
                        color: ColorValue.bluePricecolor,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 15,),
                    Text(
                      'Deskripsi Produk',
                      // widget.verifikasiModel.deskripsi == null ? "Tidak tertera Deskripsi" : widget.verifikasiModel.deskripsi.toString(),
                      style: textTheme.headline6!.copyWith(
                        color: ColorValue.hintColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 10,),
              const Divider(
                color: ColorValue.hintColor,
                thickness: 0.5,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 15, 24, 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Ketersediaan",
                          style: TextStyle(
                            color: ColorValue.neutralColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 5,),
                        Text(
                          widget.verifikasiModel.stok == null ? "Tidak tertera Ketersediaan" : "${widget.verifikasiModel.stok.toString()} Stock",
                          style: const TextStyle(
                            color: ColorValue.hintColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Varian",
                          style: textTheme.headline6!.copyWith(
                            color: ColorValue.neutralColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 5,),
                        Row(
                          children: [
                            chipVarian("1/KG"),
                            const SizedBox(width: 5,),
                            chipVarian("2/KG"),
                            const SizedBox(width: 5,),
                            chipVarian("3/KG"),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
              const Divider(
                color: ColorValue.hintColor,
                thickness: 0.5,
              ),
              if(widget.verifikasiModel.status == "Rejected")
                main_button("Lihat alasan ditolak", context, onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => AlasanDitolakPage(
                    data: widget.verifikasiModel,
                  )));
                })
            ],
          ),
        ),
      ),
    );
  }

  Widget chipVarian(String textVarian){
    return Container(
      alignment: Alignment.center,
      height: 30,
      width: 45,
      decoration: BoxDecoration(
        border: Border.all(
          color: ColorValue.neutralColor,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        textVarian,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.subtitle1!.copyWith(
          fontWeight: FontWeight.w500,
          fontSize: 14,
          color: ColorValue.neutralColor,
        ),
      ),
    );
  }
}
