import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kangsayur_seller/common/color_value.dart';
import 'package:kangsayur_seller/model/user_model.dart';
import 'package:kangsayur_seller/ui/auth/login/login.dart';
import 'package:kangsayur_seller/ui/on_boarding/on_boarding_screen.dart';
import 'package:kangsayur_seller/ui/profile/option_profile.dart';
import 'package:kangsayur_seller/ui/promo/promo.dart';
import 'package:kangsayur_seller/ui/seller_care/seller_care.dart';
import 'package:kangsayur_seller/ui/transaksi/transaksi.dart';
import 'package:kangsayur_seller/ui/ulasan/review_ulasan_all.dart';
import 'package:kangsayur_seller/ui/widget/main_button.dart';
import 'package:http/http.dart' as http;
import 'package:shimmer/shimmer.dart';
import '../../profile/inbox.dart';
import '../../ulasan/ulasan.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  bool isLoadedBg = false;
  UserModel? userModel;

  Future _logout() async {

    setState(() {
      isLoadedBg = false;
    });

    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('token');
    final responseLogout = await http.get(Uri.parse("https://kangsayur.nitipaja.online/api/auth/logout"),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },);

    print(responseLogout.statusCode);

    setState(() {
      isLoadedBg = true;
    });
  }

  Future _personalInformation() async {
    setState(() {
      isLoadedBg = false;
    });

    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('token');
    final responseUser = await http.get(Uri.parse("https://kangsayur.nitipaja.online/api/seller/profile"),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },);

    userModel = UserModel.fromJson(jsonDecode(responseUser.body.toString()));

    print(responseUser.statusCode);

    setState(() {
      isLoadedBg = true;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _personalInformation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoadedBg ? SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Column(
            children: [
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const OptionProfile()));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundImage: Image.network("https://kangsayur.nitipaja.online/${userModel!.data.imgProfile}").image,
                        ),
                        const SizedBox(width: 16,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              userModel!.data.namaToko,
                              style: Theme.of(context).textTheme.headline6!.copyWith(
                                color: ColorValue.neutralColor,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              userModel!.data.email,
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
                                KategoriProfile("Kelola Ulasan", "assets/svg/kelola_ulasan.svg", onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => const ReviewUlasanPage()));
                                }),
                                const SizedBox(width: 25,),
                                KategoriProfile("Seller Care", "assets/svg/seller.svg", onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => const SellerCarePage()));
                                }),
                              ],
                            ),
                            const SizedBox(height: 40,),
                            Row(
                              children: [
                                KategoriProfile("Transaksi", "assets/svg/pembayaran.svg", onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => const TranskasiPage()));
                                }),
                                const SizedBox(width: 50,),
                                KategoriProfile("Promo", "assets/svg/promo_profile.svg", onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => const PromoPage(selectedCategories: [])));
                                },),
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
              main_button("Keluar", context, onPressed: (){
                _logout();
                //show dialog
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text("Keluar"),
                      content: const Text("Apakah anda yakin ingin keluar?"),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("Tidak"),
                        ),
                        TextButton(
                          onPressed: () {
                            SharedPreferences.getInstance().then((prefs) {
                              prefs.remove('token');
                              prefs.clear();
                              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const OnboardingScreen()), (route) => false);
                            });
                          },
                          child: const Text("Ya"),
                        ),
                      ],
                    );
                  },
                );
              }),
            ],
          ),
        ),
      ) :
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                child:  Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundColor: Colors.white,
                            ),
                            const SizedBox(width: 16,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 20,
                                  width: 100,
                                  color: Colors.white,
                                ),
                                const SizedBox(height: 8,),
                                Container(
                                  height: 15,
                                  width: 100,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ],
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            size: 20,
                            Icons.arrow_forward_ios_outlined,
                            color: Colors.white,
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
                          color: Colors.white,
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
                                      Container(
                                        height: 50,
                                        width: 50,
                                        color: Colors.white,
                                      ),
                                      const SizedBox(width: 45,),
                                      Container(
                                        height: 50,
                                        width: 50,
                                        color: Colors.white,
                                      ),
                                      const SizedBox(width: 25,),
                                      Container(
                                        height: 50,
                                        width: 50,
                                        color: Colors.white,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 40,),
                                  Row(
                                    children: [
                                      Container(
                                        height: 50,
                                        width: 50,
                                        color: Colors.white,
                                      ),
                                      const SizedBox(width: 50,),
                                      Container(
                                        height: 50,
                                        width: 50,
                                        color: Colors.white,
                                      ),
                                      const SizedBox(width: 50,),
                                      Container(
                                        height: 50,
                                        width: 50,
                                        color: Colors.white,
                                      ),
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
                    Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
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
