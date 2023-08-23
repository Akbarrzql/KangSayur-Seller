import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kangsayur_seller/bloc/state/verifikasi_state.dart';
import 'package:kangsayur_seller/bloc/state/verify_otp_state.dart';
import 'package:kangsayur_seller/common/color_value.dart';
import 'package:kangsayur_seller/ui/auth/register/map_page.dart';

import '../../../bloc/bloc/verify_otp_bloc.dart';
import '../../../bloc/event/verify_otp_event.dart';
import '../../../repository/verify_otp_repository.dart';
import 'otp_login.dart';

class OTP extends StatefulWidget {
  OTP({Key? key,  required this.namaPemilik, required this.emailPemilik, required this.noHpPemilik, required this.alamatPemilik, required this.sandi, required this.namaToko, required this.alamatToko, required this.deskripsiToko, required this.jamBuka, required this.jamTutup, required this.image}) : super(key: key);
  final TextEditingController namaPemilik;
  final TextEditingController emailPemilik;
  final TextEditingController noHpPemilik;
  final TextEditingController alamatPemilik;
  final TextEditingController sandi;
  final TextEditingController namaToko;
  final TextEditingController deskripsiToko;
  final TextEditingController alamatToko;
  //jam buka tutup dari list operasioanl toko class
  List<TextEditingController> jamBuka = [];
  List<TextEditingController> jamTutup = [];
  File? image;

  @override
  State<OTP> createState() => _OTPState();
}

class _OTPState extends State<OTP> {

  final TextEditingController controller = TextEditingController();
  final TextEditingController controller2 = TextEditingController();
  final TextEditingController controller3 = TextEditingController();
  final TextEditingController controller4 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => VerifyOtpPageBloc(verifyOtpPageRepository: VerifyOtpPageRepositoryImpl()),
      child: BlocConsumer<VerifyOtpPageBloc, VerifyOtpState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is VerifyOtpInitial){
            return Scaffold(
              backgroundColor: Colors.white,
              body: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.only(top: 31.0, left: 24, right: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Masukkan kode OTP",
                        style: TextStyle(
                            fontSize: 24,
                            color: ColorValue.secondaryColor,
                            fontWeight: FontWeight.w800),
                      ),
                      Expanded(
                          child: otpForm(
                            controller: controller,
                            controller2: controller2,
                            controller3: controller3,
                            controller4: controller4,
                            emailPemilik: widget.emailPemilik,
                          )),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 37),
                        child: GestureDetector(
                          onTap: () {
                            if (controller.text.isNotEmpty && controller2.text.isNotEmpty && controller3.text.isNotEmpty && controller4.text.isNotEmpty) {
                              String otp = controller.text + controller2.text + controller3.text + controller4.text;
                              BlocProvider.of<VerifyOtpPageBloc>(context).add(VerifyOtpEventVerifyOtp(widget.emailPemilik.text, otp));
                            }else{
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                content: Text("Harap isi semua field"),
                              ));
                            }
                          },
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
          }else if (state is VerifikasiPageLoading){
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }else if (state is VerifyOtpSuccess) {
            return MapScreen(
              namaPemilik: widget.namaPemilik,
              emailPemilik: widget.emailPemilik,
              noHpPemilik: widget.noHpPemilik,
              alamatPemilik: widget.alamatPemilik,
              sandi: widget.sandi,
              namaToko: widget.namaToko,
              alamatToko: widget.alamatToko,
              deskripsiToko: widget.deskripsiToko,
              jamBuka: widget.jamBuka,
              jamTutup: widget.jamTutup,
              image: widget.image,
            );
          }else if (state is VerifyOtpFailure){
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }else{
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
      ),
    );
  }
}
