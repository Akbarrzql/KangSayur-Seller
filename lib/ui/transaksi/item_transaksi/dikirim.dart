import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../common/color_value.dart';

class OngoingPage extends StatefulWidget {
  const OngoingPage({Key? key}) : super(key: key);

  @override
  State<OngoingPage> createState() => _OngoingPageState();
}

class _OngoingPageState extends State<OngoingPage> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              Lottie.network("https://assets3.lottiefiles.com/packages/lf20_gxhmijxe.json", width: 300, height: 300,),
              Text(
                'Belum ada pesanan yang sedang dikirim saat ini',
                style: textTheme.headline6!.copyWith(
                  color: ColorValue.neutralColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
