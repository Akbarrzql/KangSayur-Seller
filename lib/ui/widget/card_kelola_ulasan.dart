import 'package:flutter/material.dart';

import '../../common/color_value.dart';

class CardKelolaUlasan extends StatelessWidget {
  const CardKelolaUlasan({Key? key, required this.namaProduk, required this.namaPemesan, required this.gambarProduk, required this.hargaProduk, required this.onPressed}) : super(key: key);
  final String namaProduk;
  final String namaPemesan;
  final String gambarProduk;
  final String hargaProduk;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      width: double.infinity,
      height: 110,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 1,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Image.asset(
              gambarProduk,
              width: 75,
              height: 75,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    namaProduk,
                    style: textTheme.headline6!.copyWith(
                      color: ColorValue.neutralColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    namaPemesan,
                    style: textTheme.headline6!.copyWith(
                      color: ColorValue.hintColor,
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        hargaProduk,
                        style: textTheme.headline6!.copyWith(
                          color: ColorValue.bluePricecolor,
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Container(
                        height: 25,
                        child: ElevatedButton(
                          onPressed: onPressed,
                          style: ElevatedButton.styleFrom(
                            primary: ColorValue.primaryColor,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          child: Text(
                            "Detail",
                            style: textTheme.headline6!.copyWith(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              )
          )
        ],
      ),
    );
  }
}

