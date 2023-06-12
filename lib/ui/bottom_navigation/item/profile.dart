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
                child: Container(
                  height: 330,
                  width: 315,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Color(0xffF4F4F4),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        top: 30,
                        left: 30,
                        right: 30,
                        bottom: 0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                KategoriProfile("Inbox", "assets/svg/inbox.svg",32, 32, onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => const InboxPage()));
                                }),
                                KategoriProfile("Kelola Ulasan", "assets/svg/kelola_ulasan.svg", 32, 32),
                                KategoriProfile("Seller Care", "assets/svg/seller.svg", 32, 32),
                              ],
                            ),
                            const SizedBox(height: 40,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                KategoriProfile("Transaksi", "assets/svg/pembayaran.svg", 32, 32),
                                KategoriProfile("Promo", "assets/svg/promo_profile.svg", 32, 32),
                                KategoriProfile("Toko", "assets/svg/store.svg", 32, 32),
                              ],
                            ),
                            const SizedBox(height: 40,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                KategoriProfile("Driver", "assets/svg/shipment.svg", 32, 32),
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

  Widget KategoriProfile(String title, String image, double width, double height, {VoidCallback? onTap}){
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 55,
        child: Column(
          children: [
            SvgPicture.asset(image, width: width, height: height,),
            const SizedBox(height: 10,),
            Text(
              title,
              style: Theme.of(context).textTheme.bodyText2!.copyWith(
                color: ColorValue.neutralColor,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
