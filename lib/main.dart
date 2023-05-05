import 'package:flutter/material.dart';
import 'package:kangsayur_seller/splash_screen/splash_screen.dart';
import 'package:kangsayur_seller/ui/auth/login/login.dart';
import 'package:kangsayur_seller/ui/auth/login/otp.dart';
import 'package:kangsayur_seller/ui/auth/login/otp_login.dart';
import 'package:kangsayur_seller/ui/auth/register/kategori_toko.dart';
import 'package:kangsayur_seller/ui/auth/register/nama_toko.dart';
import 'package:kangsayur_seller/ui/auth/register/register_pemilik.dart';
import 'package:kangsayur_seller/ui/auth/register/register_toko.dart';
import 'package:kangsayur_seller/ui/auth/register/sandi_register.dart';

void main() {
  runApp(const MyApp());
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
      home: const SplashScreen(),
    );
  }
}
