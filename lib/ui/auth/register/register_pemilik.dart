import 'package:flutter/material.dart';
import 'package:kangsayur_seller/common/color_value.dart';
import 'package:kangsayur_seller/ui/auth/register/nama_toko.dart';
import 'package:kangsayur_seller/ui/auth/register/register_toko.dart';
import 'package:kangsayur_seller/ui/on_boarding/on_boarding_screen.dart';
import '../../widget/textfiled.dart';

class register_pemilik extends StatefulWidget {
  const register_pemilik({Key? key}) : super(key: key);

  @override
  State<register_pemilik> createState() => _register_pemilikState();
}

class _register_pemilikState extends State<register_pemilik> {

  final _namaPemilikController = TextEditingController();
  final _emailSellerController = TextEditingController();
  final _noHpController = TextEditingController();
  final _alamatController = TextEditingController();



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
                      textfield(context, "Masukkan nama Pemilik", _namaPemilikController, TextInputType.name),
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
                      textfield(context, "Masukkan Email", _emailSellerController, TextInputType.name),
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
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: ColorValue.hintColor,
                        width: 0.5,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: TextFormField(
                        controller: _noHpController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Masukkan no handphone",
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
                            keyboardType: TextInputType.name,
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => register_toko(
                            selectedCategoriesOperasional: [],
                          ),
                        ),
                      );
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
    );
  }
}
