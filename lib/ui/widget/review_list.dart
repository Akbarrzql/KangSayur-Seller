import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kangsayur_seller/ui/widget/dialog_alret.dart';
import '../../common/color_value.dart';
import '../ulasan/detail_photo_ulasan.dart';

class ReviewWidget extends StatefulWidget {
  ReviewWidget({Key? key, required this.profile, required this.name, required this.date, required this.comment, required this.commentSeller, required this.image, required this.rating,required this.context,}) : super(key: key);
  final String profile;
  final String name;
  final String date;
  final String comment;
  final String commentSeller;
  final String image;
  final double rating;
  final BuildContext context;

  @override
  State<ReviewWidget> createState() => _ReviewWidgetState();
}

class _ReviewWidgetState extends State<ReviewWidget> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 42,
              child: Image.network(
                widget.profile,
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
                      widget.name,
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
                      initialRating: widget.rating,
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
                  widget.date,
                  style: const TextStyle(fontSize: 12, color: Color(0xffA0A0A0)),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Text(widget.comment),
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
                builder: (context) => Detail_photo(
                  image: widget.image,
                  name: widget.name,
                ),
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
                  child: Image.network(
                    widget.image,
                    fit: BoxFit.cover,
                  ),
                )
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Balasan Anda",
                style:  textTheme.bodyText1!.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 5),
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          margin: const EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: const Color(0xFFF3F3F3),
          ),
          child: Text(
            widget.commentSeller,
            style: textTheme.bodyText1!.copyWith(
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const Divider(
          height: 1,
          color: ColorValue.neutralColor,
        ),
      ],
    );
  }
}
