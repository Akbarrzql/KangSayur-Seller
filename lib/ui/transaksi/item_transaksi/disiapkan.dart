import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../common/color_value.dart';

class DisiapkanPage extends StatefulWidget {
  const DisiapkanPage({Key? key}) : super(key: key);

  @override
  State<DisiapkanPage> createState() => _DisiapkanPageState();
}

class _DisiapkanPageState extends State<DisiapkanPage> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              Lottie.network("https://assets1.lottiefiles.com/private_files/lf30_dmjtc2fu.json", width: 300, height: 300,),
              Text(
                'Belum ada pesanan yang disiapkan saat ini',
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
