import 'package:flutter/material.dart';
import 'package:kangsayur_seller/ui/auth/register/map_page.dart';
import 'package:kangsayur_seller/ui/bottom_navigation/bottom_navigation.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:kangsayur_seller/ui/bottom_navigation/item/dashboard.dart';
import 'package:kangsayur_seller/ui/bottom_navigation/item/profile.dart';
import 'package:kangsayur_seller/ui/chat/detail_chat.dart';
import 'package:kangsayur_seller/ui/chat/pengaturan_chat.dart';
import 'package:kangsayur_seller/ui/iklan/detail_iklan.dart';
import 'package:kangsayur_seller/ui/informasi/informasi.dart';
import 'package:kangsayur_seller/ui/produk/alasan_produk_ditolak.dart';
import 'package:kangsayur_seller/ui/produk/detail_produk.dart';
import 'package:kangsayur_seller/ui/produk/tambah_produk.dart';
import 'package:kangsayur_seller/ui/profile/inbox.dart';
import 'package:kangsayur_seller/ui/promo/list_promo.dart';
import 'package:kangsayur_seller/ui/promo/promo.dart';
import 'package:kangsayur_seller/ui/splash_screen/splash_screen.dart';
import 'package:kangsayur_seller/ui/ulasan/review_ulasan_all.dart';

void main() {
  initializeDateFormatting().then((_) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.green,
      ),
      home: const ProfilePage(),
    );
  }
}
