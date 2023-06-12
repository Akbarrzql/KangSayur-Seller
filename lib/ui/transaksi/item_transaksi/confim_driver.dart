import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../common/color_value.dart';

class ConfirmDriver extends StatefulWidget {
  const ConfirmDriver({Key? key}) : super(key: key);

  @override
  State<ConfirmDriver> createState() => _ConfirmDriverState();
}

class _ConfirmDriverState extends State<ConfirmDriver> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              Lottie.network("https://assets7.lottiefiles.com/packages/lf20_0vKKEb.json", width: 300, height: 300,),
              Text(
                'Belum ada pesanan yang dapat dikonfirmasi oleh driver saat ini',
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
