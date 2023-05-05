import 'package:flutter/material.dart';

class OnboardingContents {
  final String title;
  final String image;
  final String desc;

  OnboardingContents(
      {required this.title, required this.image, required this.desc});
}

List<OnboardingContents> contents = [
  OnboardingContents(
    title: "Buka Toko Kamu Sekarang",
    image: "assets/images/boarding_one.png",
    desc: "Buka toko kamu secara digital agar toko dapat diketahui oleh banyak orang",
  ),
  OnboardingContents(
    title: "Raih keuntunganmu dengan menjadi seller di Kang Sayur",
    image: "assets/images/seller_on_boarding.png",
    desc: "kamu dapat menjual hasil panenmu di tokomu, memberikan promo, dan promo kilat.",
  ),
  OnboardingContents(
    title: "Tingkatkan penjualanmu",
    image: "assets/images/boarding_three.png",
    desc: "Kamu akan mendapatkan banyak keuntungan dengan menjadi seller di Kang Sayur",
  ),
];
