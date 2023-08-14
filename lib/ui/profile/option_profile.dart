import 'package:flutter/material.dart';
import 'package:kangsayur_seller/ui/auth/password/ganti_password.dart';
import 'package:kangsayur_seller/ui/profile/kustomisasi_profile.dart';
import '../../model/user_model.dart';
import '../../common/color_value.dart';

class OptionProfile extends StatefulWidget {
  const OptionProfile({Key? key, required this.data}) : super(key: key);
  final Data data;

  @override
  State<OptionProfile> createState() => _OptionProfileState();
}

class _OptionProfileState extends State<OptionProfile> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Pengaturan Akun',
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
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => KustomisasiProfilePage(
                    data: widget.data,
                  )));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Kustomisasi",
                      style: textTheme.headline6!.copyWith(
                        color: ColorValue.neutralColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => KustomisasiProfilePage(
                          data: widget.data,
                        )));
                      },
                      icon: const Icon(
                        Icons.arrow_forward_ios,
                        color: ColorValue.neutralColor,
                        size: 16,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 5),
              InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const GantiPasswordPage()));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Ganti Password",
                      style: textTheme.headline6!.copyWith(
                        color: ColorValue.neutralColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const GantiPasswordPage()));
                      },
                      icon: const Icon(
                        Icons.arrow_forward_ios,
                        color: ColorValue.neutralColor,
                        size: 16,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
