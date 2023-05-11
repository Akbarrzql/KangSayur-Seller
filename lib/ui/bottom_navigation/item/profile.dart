import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kangsayur_seller/common/color_value.dart';
import 'package:kangsayur_seller/ui/profile/option_profile.dart';
import 'package:kangsayur_seller/ui/widget/main_button.dart';

import '../../profile/inbox.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 30,
                        backgroundImage: AssetImage('assets/images/ava_seller.png'),
                      ),
                      const SizedBox(width: 16,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Nama Seller',
                            style: Theme.of(context).textTheme.headline6!.copyWith(
                              color: ColorValue.neutralColor,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            'Email Seller',
                            style: Theme.of(context).textTheme.bodyText2!.copyWith(
                              color: ColorValue.hintColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const OptionProfile()),
                      );
                    },
                    icon: const Icon(
                      size: 20,
                      Icons.arrow_forward_ios_outlined,
                      color: ColorValue.hintColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24,),
              Center(
                widthFactor: 2,
                child: Container(
                  height: 280,
                  width: 315,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Color(0xffF4F4F4),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        top: 50,
                        left: 30,
                        right: 30,
                        bottom: 30,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                KategoriProfile("Inbox", "assets/svg/inbox.svg", onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => const InboxPage()));
                                }),
                                const SizedBox(width: 45,),
                                KategoriProfile("Kelola Ulasan", "assets/svg/kelola_ulasan.svg"),
                                const SizedBox(width: 25,),
                                KategoriProfile("Seller Care", "assets/svg/seller.svg"),
                              ],
                            ),
                            const SizedBox(height: 40,),
                            Row(
                              children: [
                                KategoriProfile("Transaksi", "assets/svg/pembayaran.svg"),
                                const SizedBox(width: 50,),
                                KategoriProfile("Promo", "assets/svg/promo_profile.svg"),
                                const SizedBox(width: 50,),
                                KategoriProfile("Toko", "assets/svg/toko.svg"),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24,),
              main_button("Keluar", context, onPressed: (){}),
            ],
          ),
        ),
      )
    );
  }

  Widget KategoriProfile(String title, String image, {VoidCallback? onTap}){
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          SvgPicture.asset(image),
          const SizedBox(height: 10,),
          Text(
            title,
            style: Theme.of(context).textTheme.bodyText2!.copyWith(
              color: ColorValue.neutralColor,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
