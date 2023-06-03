import 'package:flutter/material.dart';
import 'package:kangsayur_seller/ui/iklan/detail_iklan.dart';
import 'package:kangsayur_seller/ui/widget/main_button.dart';

import '../../common/color_value.dart';

class InformasiIklanPage extends StatefulWidget {
  const InformasiIklanPage({Key? key}) : super(key: key);

  @override
  State<InformasiIklanPage> createState() => _InformasiIklanPageState();
}

class _InformasiIklanPageState extends State<InformasiIklanPage> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Informasi Iklan',
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
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/information.png',
                width: 200,
                height: 200,
              ),
              SizedBox(height: 10,),
              Text(
                "Setelah melakukan pembayaran, informasi penanyangan iklan mu akan di beritahukan melalui inbox",
                style: Theme.of(context).textTheme.bodyText2!.copyWith(
                  color: ColorValue.neutralColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20,),
              main_button("Inbox", context, onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => const DetailIklan() ));
              })
            ],
          )
        ),
      ),
    );
  }
}
