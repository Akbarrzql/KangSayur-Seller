import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kangsayur_seller/ui/widget/dialog_alret.dart';
import '../../common/color_value.dart';
import '../ulasan/detail_photo_ulasan.dart';

class ReviewWidget extends StatefulWidget {
  ReviewWidget({Key? key, required this.profile, required this.name, required this.date, required this.comment, required this.image, required this.rating, required this.isExpanded, required this.replyController, required this.context, required this.isReplyVisible}) : super(key: key);
  final String profile;
  final String name;
  final String date;
  final String comment;
  final String image;
  final double rating;
  final bool isExpanded;
  bool isReplyVisible;
  final TextEditingController replyController;
  final BuildContext context;

  @override
  State<ReviewWidget> createState() => _ReviewWidgetState();
}

class _ReviewWidgetState extends State<ReviewWidget> {

  List<String> reply = [];



  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return WillPopScope(
      onWillPop: () async {
        if (widget.isReplyVisible) {
          setState(() {
            widget.isReplyVisible = false;
          });
          return false;
        } else {
          return true;
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 42,
                child: Image.asset(
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
                GestureDetector(
                  onTap: () {
                    //ketika di klik balas maka akan menampilakn textfield untuk membalas di bawah review
                    setState(() {
                      widget.isReplyVisible = true;
                    });
                  },
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
          ),
          const SizedBox(height: 5),
          if (widget.isReplyVisible)
             TextField(
                controller: widget.replyController,
                decoration: InputDecoration(
                  hintText: "Tulis balasan Anda",
                  hintStyle: textTheme.bodyText1!.copyWith(
                    fontSize: 12,
                    color: ColorValue.neutralColor,
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        reply.add(widget.replyController.text);
                        widget.isReplyVisible = false;
                        widget.replyController.clear();
                      });
                    },
                    icon: const Icon(
                      Icons.send,
                      color: ColorValue.primaryColor,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: ColorValue.hintColor,
                        width: 0.5
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: ColorValue.hintColor,
                        width: 0.5
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: ColorValue.hintColor,
                      width: 0.5
                    ),
                  ),
                ),
              ),
          const SizedBox(height: 5),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: reply.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onLongPress: (){
                  setState(() {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text("Hapus Balasan"),
                            content: const Text("Apakah Anda yakin ingin menghapus balasan ini?"),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text("Tidak"),
                              ),
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    reply.removeAt(index);
                                    Navigator.pop(context);
                                  });
                                },
                                child: const Text("Ya"),
                              ),
                            ],
                          );
                        }
                    );
                  });
                },
                child: Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  margin: const EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: const Color(0xFFF3F3F3),
                  ),
                  child: Text(
                    reply[index],
                    style: textTheme.bodyText1!.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              );
            },
          ),
          const Divider(
            height: 1,
            color: ColorValue.neutralColor,
          ),
        ],
      ),
    );
  }
}
