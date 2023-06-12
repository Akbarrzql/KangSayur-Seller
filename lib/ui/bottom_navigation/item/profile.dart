import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
import '../../../bloc/bloc/profile_bloc.dart';
import '../../../bloc/event/profile_event.dart';
import '../../../bloc/state/profile_state.dart';
import '../../../repository/profile_repository.dart';
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
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: isLoadedBg ? SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Column(
            children: [
              BlocProvider(
                  create: (context) => ProfilePageBloc(profilePageRepository: ProfileRepository())..add(GetProfile()),
                  child: BlocBuilder<ProfilePageBloc, ProfilePageState>(
                    builder: (context, state){
                      if (state is ProfilePageLoading) {
                        return Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Row(
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
                        );
                      }
                      else if (state is ProfilePageLoaded){
                        return GestureDetector(
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
                                    backgroundImage: Image.network("https://kangsayur.nitipaja.online/${state.userModel!.data.imgProfile}").image,
                                  ),
                                  const SizedBox(width: 16,),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        state.userModel!.data.namaToko,
                                        style: Theme.of(context).textTheme.headline6!.copyWith(
                                          color: ColorValue.neutralColor,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                        state.userModel!.data.email,
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
                        );
                      }
                      else if (state is ProfilePageError){
                        return Text(
                          "Kesalahan dalam mengambil data",
                          style: textTheme.bodyText1!.copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: ColorValue.neutralColor),
                        );
                      }
                      else{
                        return Text(
                          "Kesalahan dalam mengambil data",
                          style: textTheme.bodyText1!.copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: ColorValue.neutralColor),
                        );
                      }
                    },
                  )
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
              main_button("Keluar", context, onPressed: (){
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
