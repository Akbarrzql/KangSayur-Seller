import 'package:flutter/material.dart';

import '../../common/color_value.dart';

class PengaturanTokoPage extends StatefulWidget {
  const PengaturanTokoPage({Key? key}) : super(key: key);

  @override
  State<PengaturanTokoPage> createState() => _PengaturanTokoPageState();
}

class _PengaturanTokoPageState extends State<PengaturanTokoPage> {

  //switch value
  bool _value  = false;
  bool _value2 = false;
  bool _value3 = false;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Pengaturan Toko',
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
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Standar balas otomatis",
                        style: textTheme.headline6!.copyWith(
                          color: ColorValue.neutralColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        "Jangan sampai ada chat yang terlewatkan",
                        style: textTheme.bodyText2!.copyWith(
                          color: ColorValue.neutralColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  Switch(
                    value: _value,
                    onChanged: (value) {
                      setState(() {
                        _value = value;
                      });
                    },
                    activeColor: ColorValue.primaryColor,
                  ),
                ],
              ),
              const Divider(
                color: ColorValue.neutralColor,
                thickness: 0.5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: Text(
                          "Balas otomatis di luar waktu operasional",
                          style: textTheme.headline6!.copyWith(
                            color: ColorValue.neutralColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: Text(
                          "Tak perlu repot, anda dapat membalas chat di luar waktu operasional",
                          style: textTheme.bodyText2!.copyWith(
                            color: ColorValue.neutralColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      )
                    ],
                  ),
                  Switch(
                    value: _value2,
                    onChanged: (value) {
                      setState(() {
                        _value2 = value;
                      });
                    },
                    activeColor: ColorValue.primaryColor,
                  ),
                ],
              ),
              const Divider(
                color: ColorValue.neutralColor,
                thickness: 0.5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Balas otamatis toko tutup",
                        style: textTheme.headline6!.copyWith(
                          color: ColorValue.neutralColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        "Buat balasan chat jika toko anda tutup.",
                        style: textTheme.bodyText2!.copyWith(
                          color: ColorValue.neutralColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  Switch(
                    value: _value3,
                    onChanged: (value) {
                      setState(() {
                        _value3 = value;
                      });
                    },
                    activeColor: ColorValue.primaryColor,
                  ),
                ],
              ),
              const Divider(
                color: ColorValue.neutralColor,
                thickness: 0.5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
