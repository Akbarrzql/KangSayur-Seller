import 'package:flutter/material.dart';
import 'package:kangsayur_seller/common/color_value.dart';

import 'otp_login.dart';

class OTP extends StatefulWidget {
  const OTP({Key? key}) : super(key: key);

  @override
  State<OTP> createState() => _OTPState();
}

class _OTPState extends State<OTP> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(top: 31.0, left: 24, right: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Masukkan kode OTP",
                style: TextStyle(
                    fontSize: 24,
                    color: ColorValue.secondaryColor,
                    fontWeight: FontWeight.w800),
              ),
              Expanded(child: otpForm()),
              Padding(
                padding: EdgeInsets.only(bottom: 37),
                child: GestureDetector(
                  onTap: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const OTP())),
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                        color: ColorValue.primaryColor,
                        borderRadius: BorderRadius.circular(5)),
                    child: const Center(
                      child: Text(
                        "Verifikasi",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
