import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../common/color_value.dart';

class DetailProduk extends StatefulWidget {
  const DetailProduk({Key? key}) : super(key: key);

  @override
  State<DetailProduk> createState() => _DetailProdukState();
}

class _DetailProdukState extends State<DetailProduk> {
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
                              '2 Maret 2023',
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
                        color: const Color(0xFFD7FEDF),
                      ),
                      child: Text(
                        "Terverifikasi",
                        style: Theme.of(context).textTheme.subtitle1!.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: ColorValue.primaryColor,
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
                padding: const EdgeInsets.fromLTRB(24, 15, 24, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Wortel 1/KG",
                      style: textTheme.headline6!.copyWith(
                        color: ColorValue.neutralColor,
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 5,),
                    Text(
                      "Rp. 10.000",
                      style: textTheme.headline6!.copyWith(
                        color: ColorValue.bluePricecolor,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 15,),
                    Text(
                      "Wortel yang kami tawarkan adalah segar dan berkualitas, serta dipanen dengan teliti untuk memastikan kualitas terbaik. Dapatkan wortel segar dengan harga yang terjangkau hanya di toko bu Endah.",
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
                      children: const [
                        Text(
                          "Ketersediaan",
                          style: TextStyle(
                            color: ColorValue.neutralColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 5,),
                        Text(
                          "100 KG",
                          style: TextStyle(
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
