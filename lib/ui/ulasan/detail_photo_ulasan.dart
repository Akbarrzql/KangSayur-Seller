import 'package:flutter/material.dart';
import 'package:kangsayur_seller/common/color_value.dart';
import 'package:photo_view/photo_view.dart';

class Detail_photo extends StatefulWidget {
  const Detail_photo({Key? key}) : super(key: key);

  @override
  State<Detail_photo> createState() => _Detail_photoState();
}

class _Detail_photoState extends State<Detail_photo> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: ColorValue.primaryColor,
        title: Text(
          'Detail Foto',
          style: Theme.of(context).textTheme.headline6!.copyWith(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.87,
              width: MediaQuery.of(context).size.width,
              child: PhotoView(
                imageProvider:
                AssetImage("assets/images/wortel.png"),
                heroAttributes:
                PhotoViewHeroAttributes(tag: "someTag"),
              ),
            )
          ],
        ),
      ),
    );
  }
}