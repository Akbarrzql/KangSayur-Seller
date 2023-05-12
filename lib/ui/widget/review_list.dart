import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';

import '../../common/color_value.dart';
import '../ulasan/detail_photo_ulasan.dart';

Widget Review({
  required String profile,
  required String name,
  required String date,
  required String comment,
  required String image,
  required double rating,
  required BuildContext context,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 42,
            child: Image.asset(
              profile,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    name,
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  RatingBar.builder(
                    itemBuilder: (context, index) {
                      return const Icon(Icons.star, color: Colors.amber);
                    },
                    onRatingUpdate: (value) {},
                    initialRating: rating,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemSize: 14,
                    itemPadding: const EdgeInsets.only(right: 1),
                    minRating: 1,
                    glow: false,
                    unratedColor: ColorValue.neutralColor,
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                date,
                style: const TextStyle(fontSize: 12, color: Color(0xffA0A0A0)),
              ),
            ],
          ),
        ],
      ),
      const SizedBox(
        height: 10,
      ),
      Text(comment),
      const SizedBox(
        height: 15,
      ),
      //make image review
      GestureDetector(
        onTap: () {
          //make navigate to detail_photo
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const Detail_photo(),
            ),
          );
        },
        child: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Hero(
            tag: "someTag",
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Image.asset(
                image,
                fit: BoxFit.cover,
              ),
            )
          ),
        ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          GestureDetector(
            onTap: () {},
            child: const Text(
              "Balas",
              style: TextStyle(
                fontSize: 12,
                color: ColorValue.neutralColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
      const SizedBox(
        height: 15,
      ),
      const Divider(
        height: 1,
        color: ColorValue.neutralColor,
      ),
    ],
  );
}