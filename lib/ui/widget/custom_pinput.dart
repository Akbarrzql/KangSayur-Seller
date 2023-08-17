import 'package:google_fonts/google_fonts.dart';
import 'package:kangsayur_seller/common/color_value.dart';
import 'package:pinput/pinput.dart';
import 'package:flutter/material.dart';

final defaultPinTheme = PinTheme(
  width: 56,
  height: 56,
  textStyle: GoogleFonts.nunito(
    fontSize: 20,
    color: Colors.black,
    fontWeight: FontWeight.w600,
  ),
  decoration: BoxDecoration(
    color: ColorValue.hintColor,
    borderRadius: BorderRadius.circular(16),
  ),
);

final focusedPinTheme = defaultPinTheme.copyDecorationWith(
  border: Border.all(
    color: ColorValue.primaryColor,
  ),
);

final submittedPinTheme = defaultPinTheme.copyWith(
  decoration: defaultPinTheme.decoration!.copyWith(),
);

class CustomPinPut extends StatelessWidget {
  const CustomPinPut({super.key, required this.controller, this.validator});
  final TextEditingController controller;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Pinput(
      controller: controller,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      defaultPinTheme: defaultPinTheme,
      focusedPinTheme: focusedPinTheme,
      submittedPinTheme: submittedPinTheme,
      validator: validator,
    );
  }
}