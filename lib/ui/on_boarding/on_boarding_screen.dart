import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kangsayur_seller/ui/auth/login/login.dart';
import 'package:kangsayur_seller/ui/auth/register/register_pemilik.dart';
import 'package:kangsayur_seller/ui/on_boarding/size_config.dart';
import '../../common/color_value.dart';
import '../auth/register/register_pemilik.dart';
import 'on_boarding_content.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _controller = PageController();
  int _currentPage = 0;
  List colors = [Colors.white, Colors.white, Colors.white];


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Timer.periodic(Duration(seconds: 3), (Timer timer) {
      if (_currentPage < contents.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _controller.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    });
  }

  AnimatedContainer _buildDots({int? index}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(50),
        ),
        color: _currentPage == index
            ? ColorValue.primaryColor
            : ColorValue.secondaryColor.withOpacity(0.5),
      ),
      margin: const EdgeInsets.only(right: 10),
      height: 10,
      curve: Curves.easeIn,
      width: _currentPage == index ? 10 : 10,
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: PageView.builder(
                controller: _controller,
                onPageChanged: (value) => setState(() => _currentPage = value),
                itemCount: contents.length,
                itemBuilder: (context, i) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 90, left: 40, right: 40),
                    child: Column(
                      children: [
                        Image.asset(
                          contents[i].image,
                          height: SizeConfig.blockV! * 35,
                        ),
                        Text(
                          contents[i].title,
                          style: textTheme.headline6!.copyWith(
                            color: ColorValue.secondaryColor,
                            fontWeight: FontWeight.w900,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Text(
                          contents[i].desc,
                          textAlign: TextAlign.center,
                          style: textTheme.bodyText1!.copyWith(
                            color: const Color(0xffB6B6B6),
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      contents.length,
                          (int index) => _buildDots(index: index),
                    ),
                  ),
                  if (_currentPage + 1 == contents.length) Padding(
                    padding: const EdgeInsets.only(bottom: 60, right: 24, left: 24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const login_screen(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ColorValue.primaryColor,
                            elevation: 0,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 50, vertical: 15),
                          ),
                          child: Text("Masuk",
                            style: textTheme.headline4!.copyWith(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const register_pemilik(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            side: const BorderSide(
                                color: ColorValue.primaryColor, width: 1),
                            elevation: 0,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 50, vertical: 15),
                          ),
                          child: Text("Daftar", style: textTheme.headline4!.copyWith(
                            color: ColorValue.primaryColor,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),),
                        ),
                      ],
                    ),
                  ) else Padding(
                    padding: const EdgeInsets.only(bottom: 60, right: 24, left: 24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const login_screen(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ColorValue.primaryColor,
                            elevation: 0,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 50, vertical: 15),
                          ),
                          child: Text("Masuk",
                            style: textTheme.headline4!.copyWith(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const register_pemilik(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              side: const BorderSide(
                                  color: ColorValue.primaryColor, width: 1),
                              elevation: 0,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 50, vertical: 15),
                              foregroundColor: Colors.white
                          ),
                          child: Text("Daftar", style: textTheme.headline4!.copyWith(
                            color: ColorValue.primaryColor,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}