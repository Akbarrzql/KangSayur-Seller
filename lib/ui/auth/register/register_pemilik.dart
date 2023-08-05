import 'package:flutter/material.dart';
import 'package:kangsayur_seller/common/color_value.dart';
import 'package:kangsayur_seller/ui/auth/register/nama_toko.dart';
import 'package:kangsayur_seller/ui/auth/register/register_toko.dart';
import 'package:kangsayur_seller/ui/auth/register/sandi_register.dart';
import 'package:kangsayur_seller/ui/on_boarding/on_boarding_screen.dart';
import '../../../validator/input_validator.dart';
import '../../widget/custom_textfield.dart';
import '../../widget/textfiled.dart';

class register_pemilik extends StatefulWidget {
  const register_pemilik({Key? key}) : super(key: key);

  @override
  State<register_pemilik> createState() => _register_pemilikState();
}

class _register_pemilikState extends State<register_pemilik> {

  final _namaPemilikController = TextEditingController();
  final _emailPemilikController = TextEditingController();
  final _noHpController = TextEditingController();
  final _alamatController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pendaftaran Pemilik Toko",
        style: TextStyle(color: Colors.black, fontSize: 18),),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => OnboardingScreen()),
                  (Route<dynamic> route) => false),
        ),
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Container(
            height: MediaQuery.of(context).size.height,
            padding: EdgeInsets.all(24),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Form(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Nama Pemilik',
                          style: Theme.of(context).textTheme.subtitle1!.copyWith(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: ColorValue.neutralColor,
                          ),
                          textAlign: TextAlign.start,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        CustomTextFormField(
                          controller: _namaPemilikController,
                          label: 'Masukkan Nama Pemilik',
                          textInputType: TextInputType.name,
                          validator: (value) => InputValidator.nameTokoValidator(value),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Email',
                          style: Theme.of(context).textTheme.subtitle1!.copyWith(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: ColorValue.neutralColor,
                          ),
                          textAlign: TextAlign.start,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        CustomTextFormField(
                          controller: _emailPemilikController,
                          label: 'Masukkan Email',
                          textInputType: TextInputType.emailAddress,
                          validator: (value) => InputValidator.emailValidator(value),
                        ),
                        SizedBox(height: 20,),
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: const Color(0xffD7FEDF),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          height: 55,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.info_outline,
                                color: ColorValue.primaryColor,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Text(
                                  "No handphone menggunakan fomat +62 anda tidak perlu menambahkan angka 0 di awal.",
                                  style: Theme.of(context).textTheme.subtitle1!.copyWith(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                    color: ColorValue.primaryColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20,),
                        Text(
                          'Nomor HP Pemilik',
                          style: Theme.of(context).textTheme.subtitle1!.copyWith(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: ColorValue.neutralColor,
                          ),
                          textAlign: TextAlign.start,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                              color: ColorValue.hintColor,
                              width: 0.5,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: TextFormField(
                              controller: _noHpController,
                              keyboardType: TextInputType.phone,
                              validator: (value) =>  InputValidator.phoneValidator(value),
                              autofillHints: const [AutofillHints.telephoneNumber],
                              maxLength: 11,
                              buildCounter: (BuildContext context, { int? currentLength, int? maxLength, bool? isFocused }) => null,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                prefixText: "+62 ",
                                prefixStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
                                  color: ColorValue.primaryColor,
                                ),
                                hintText: "Masukkan No. HP",
                                hintStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
                                  color: ColorValue.hintColor,
                                ),
                              ),
                            ),

                          ),
                        ),
                        SizedBox(height: 20,),
                        Text(
                          'Alamat Lengkap Pemilik',
                          style: Theme.of(context).textTheme.subtitle1!.copyWith(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: ColorValue.neutralColor,
                          ),
                          textAlign: TextAlign.start,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: ColorValue.hintColor,
                              width: 0.5,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: TextFormField(
                              controller: _alamatController,
                              minLines: 1,
                              maxLines: 10,
                              textInputAction: TextInputAction.newline,
                              validator: (value) => InputValidator.addressValidator(value),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Masukkan alamat",
                                hintStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
                                  color: ColorValue.hintColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20,),
                  Container(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if(_formKey.currentState!.validate()){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => KataSandiRegister(
                              namaPemilik: _namaPemilikController,
                              emailPemilik: _emailPemilikController,
                              noHpPemilik: _noHpController,
                              alamatPemilik: _alamatController,
                            )),
                          );
                        }else{
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              backgroundColor: Colors.red,
                              margin: EdgeInsets.fromLTRB(24, 0, 24, 80),
                              behavior: SnackBarBehavior.floating,
                              content: Text('Mohon isi semua data dengan benar'),
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        primary: ColorValue.primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: Text(
                          'Selanjutnya',
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        ),
    );
  }
}
