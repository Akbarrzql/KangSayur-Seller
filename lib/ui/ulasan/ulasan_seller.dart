import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kangsayur_seller/bloc/event/ulasan_seller_event.dart';
import 'package:kangsayur_seller/bloc/state/ulasan_seller_state.dart';
import 'package:kangsayur_seller/model/ulasan_seller_model.dart';
import 'package:intl/intl.dart';
import 'package:kangsayur_seller/ui/ulasan/review_ulasan_all.dart';
import '../../bloc/bloc/ulasan_seller_bloc.dart';
import '../../common/color_value.dart';
import '../../repository/balasan_user_repository.dart';
import '../../repository/ulasan_seller_repository.dart';

class Ulasan extends StatefulWidget {
  const Ulasan({super.key, required this.data});

  final Datum? data;

  @override
  State<Ulasan> createState() => _UlasanState();
}

class _UlasanState extends State<Ulasan> {
  final ImagePicker _picker = ImagePicker();
  File? _imageFile;
  String comment = "";

  Future<void> _getImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  TextEditingController commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Balas Ulasan",
          style: TextStyle(color: ColorValue.neutralColor, fontSize: 16),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: ColorValue.neutralColor,
            )),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Head_mengulas(
              nama_seller: widget.data!.namaToko,
              alamat_seller: widget.data!.alamatToko,
              profil_seller:
                  "https://kangsayur.nitipaja.online/${widget.data!.gambarToko}",
            ),
            const SizedBox(
              height: 20,
            ),
            card_mengulas(
                gambar_produk:
                    'https://kangsayur.nitipaja.online/${widget.data!.gambarVariant}',
                nama_seller: widget.data!.namaToko,
                alamat_seller: "Jl. Raya Bogor KM 30",
                jumlah_pembelian: "2"),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget card_mengulas({
    required String gambar_produk,
    required String nama_seller,
    required String alamat_seller,
    required String jumlah_pembelian,
  }) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      margin: const EdgeInsets.only(left: 24, right: 24),
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            spreadRadius: 0,
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 50,
                height: 50,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Image.network(
                  gambar_produk,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                width: 17,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.data!.namaProduk,
                    style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: ColorValue.neutralColor),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    widget.data!.namaToko,
                    style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                        color: ColorValue.hintColor),
                  ),
                ],
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 20,
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 1,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  margin: const EdgeInsets.only(right: 10),
                  alignment: Alignment.center,
                  height: 20,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: const Color(0xFFD7FEDF),
                  ),
                  child: Text(
                    widget.data!.jenisVariant,
                    style: Theme.of(context).textTheme.subtitle1!.copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: 10,
                          color: ColorValue.primaryColor,
                        ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Tanggal Pembelian",
                style: textTheme.subtitle1!.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                  color: ColorValue.neutralColor,
                ),
              ),
              Text(
                DateFormat('dd MMMM yyyy').format(
                    DateTime.parse(widget.data!.tanggalReview.toString())),
                style: textTheme.subtitle1!.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                  color: ColorValue.neutralColor,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Kode Transaksi",
                style: textTheme.subtitle1!.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                  color: ColorValue.neutralColor,
                ),
              ),
              Text(
                widget.data!.kodeTransaksi.toString(),
                style: textTheme.subtitle1!.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                  color: ColorValue.neutralColor,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          const Divider(
            color: ColorValue.hintColor,
            thickness: 0.5,
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            "Ulasan Pembeli",
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: ColorValue.neutralColor),
          ),
          const SizedBox(
            height: 5,
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            margin: const EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: const Color(0xFFF3F3F3),
            ),
            child: Text(
              widget.data!.reviewUser,
              style: textTheme.bodyText1!.copyWith(
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            "Balasan untuk Pembeli",
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: ColorValue.neutralColor),
          ),
          const SizedBox(
            height: 5,
          ),
          Container(
            height: 122,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: ColorValue.hintColor, width: 0.5),
            ),
            child: TextField(
              maxLines: 5,
              controller: commentController,
              textAlign: TextAlign.start,
              keyboardType: TextInputType.multiline,
              onChanged: (value) {
                setState(() {
                  comment = value;
                });
              },
              style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  color: ColorValue.neutralColor),
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: "Jangan lupa berikan balasan ya!",
                hintStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    color: ColorValue.hintColor),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          BlocProvider(
              create: (context) => UlasanSellerPageBloc(
                  ulasanSellerPageRepository: UlasanSellerRepository(),
                  balasanUserSellerRepository: BalasanUserSellerRepository()),
              child: BlocConsumer<UlasanSellerPageBloc, UlasanSellerPageState>(
                listener: (context, state) {},
                builder: (context, state) {
                  if (state is InitialUlasanSellerPageState) {
                    return GestureDetector(
                      onTap: () {
                        if (comment.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              backgroundColor: Colors.red,
                              margin: EdgeInsets.fromLTRB(24, 0, 24, 30),
                              behavior: SnackBarBehavior.floating,
                              content: Text("Kolom ulasan tidak boleh kosong"),
                            ),
                          );
                        } else {
                          BlocProvider.of<UlasanSellerPageBloc>(context).add(
                              PutReplyUser(
                                  widget.data!.produkId.toString(),
                                  widget.data!.variantId.toString(),
                                  widget.data!.kodeTransaksi.toString(),
                                  commentController.text,
                                  widget.data!.userId.toString()));
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              backgroundColor: ColorValue.primaryColor,
                              margin: EdgeInsets.fromLTRB(24, 0, 24, 30),
                              behavior: SnackBarBehavior.floating,
                              content: Text("Berhasil mengirim balasan"),
                            ),
                          );
                        }
                      },
                      child: Container(
                        height: 54,
                        decoration: BoxDecoration(
                          color: ColorValue.primaryColor,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Kirim Balasan",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    );
                  } else if (state is UlasanSellerPageLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is UlasanSellerPageLoaded) {
                    return const ReviewUlasanPage();
                  } else if (state is UlasanSellerPageError) {
                    return const ReviewUlasanPage();
                  }
                    else {
                    return GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ReviewUlasanPage()));
                      },
                      child: Container(
                        height: 54,
                        decoration: BoxDecoration(
                          color: ColorValue.primaryColor,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Lihat Semua Ulasan",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                },
              ))
        ],
      ),
    );
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: 150,
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                Text(
                  "Pilih Foto",
                  style: Theme.of(context).textTheme.subtitle1!.copyWith(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: ColorValue.neutralColor,
                      ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        _getImage(ImageSource.camera);
                        Navigator.pop(context);
                      },
                      child: Column(
                        children: [
                          const Icon(
                            Icons.camera_alt_outlined,
                            color: ColorValue.primaryColor,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Kamera",
                            style:
                                Theme.of(context).textTheme.subtitle1!.copyWith(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                      color: ColorValue.neutralColor,
                                    ),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(

                      onTap: () {
                        _getImage(ImageSource.gallery);
                        Navigator.pop(context);
                      },
                      child: Column(
                        children: [
                          const Icon(
                            Icons.photo_outlined,
                            color: ColorValue.primaryColor,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Galeri",
                            style:
                                Theme.of(context).textTheme.subtitle1!.copyWith(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                      color: ColorValue.neutralColor,
                                    ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }
}

class Head_mengulas extends StatelessWidget {
  const Head_mengulas(
      {Key? key,
      required this.profil_seller,
      required this.nama_seller,
      required this.alamat_seller})
      : super(key: key);
  final String profil_seller;
  final String nama_seller;
  final String alamat_seller;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 24, right: 24),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 63,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(2)),
            child: Image.network(
              profil_seller,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(nama_seller,
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: ColorValue.neutralColor)),
                const SizedBox(
                  height: 2,
                ),
                Text(alamat_seller,
                    style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                        color: ColorValue.hintColor)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Card_mengulas extends StatefulWidget {
  Card_mengulas({
    Key? key,
    required this.gambar_produk,
    required this.nama_produk,
    required this.nama_seller,
    this.rating = 0.0,
  }) : super(key: key);
  final String gambar_produk;
  final String nama_produk;
  final String nama_seller;
  double rating = 0.0;

  @override
  State<Card_mengulas> createState() => _Card_mengulasState();
}

class _Card_mengulasState extends State<Card_mengulas> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 24, right: 24),
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            spreadRadius: 0,
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 50,
                height: 50,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Image.asset(
                  widget.gambar_produk,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                width: 17,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.nama_produk,
                    style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: ColorValue.neutralColor),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    widget.nama_seller,
                    style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                        color: ColorValue.hintColor),
                  ),
                ],
              )
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            "Ulasan Pembeli",
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: ColorValue.neutralColor),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            "Ceritakan pengalamanmu",
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: ColorValue.neutralColor),
          ),
          const SizedBox(
            height: 5,
          ),
          Container(
            height: 122,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: const Color(0xfff6f6f6),
              borderRadius: BorderRadius.circular(5),
            ),
            child: const TextField(
              maxLines: 5,
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  color: ColorValue.neutralColor),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Ceritakan pengalamanmu",
                hintStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    color: ColorValue.hintColor),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () {},
            child: Container(
              height: 54,
              decoration: BoxDecoration(
                color: ColorValue.primaryColor,
                borderRadius: BorderRadius.circular(5),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.camera_alt_outlined,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Tambahkan Foto",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
