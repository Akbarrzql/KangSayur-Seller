import 'package:flutter/material.dart';
import 'package:kangsayur_seller/common/color_value.dart';

class CardProduk extends StatelessWidget {
  const CardProduk({Key? key, required this.imageProduk, required this.namaProduk, required this.penjualProduk, required this.hargaProduk, required this.isSelected}) : super(key: key);
  final String imageProduk;
  final String namaProduk;
  final String penjualProduk;
  final String hargaProduk;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          Container(
              width: 145,
              height: 248,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.25),
                    spreadRadius: 0,
                    blurRadius: 1,
                    offset: Offset(0, 1), // changes position of shadow
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 145,
                        height: 112,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          image:  DecorationImage(
                            image: Image.network(imageProduk).image,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(9, 0, 9, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 9,
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  namaProduk,
                                  style: Theme.of(context).textTheme.subtitle1!.copyWith(
                                    fontSize: 14,
                                    color: ColorValue.neutralColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  penjualProduk,
                                  style:Theme.of(context).textTheme.subtitle1!.copyWith(
                                    fontSize: 10,
                                    color: ColorValue.neutralColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(9, 0, 9, 7),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          hargaProduk,
                          style: TextStyle(
                              fontSize: 12,
                              color: Color(0xff3D5A80),
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
