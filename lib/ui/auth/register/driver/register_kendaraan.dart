import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:kangsayur_seller/ui/informasi_driver/info_registrasi.dart';
import 'package:kangsayur_seller/ui/widget/main_button.dart';

import '../../../../common/color_value.dart';
import '../../../widget/textfiled.dart';

class RegisterKendaraan extends StatefulWidget {
  const RegisterKendaraan({Key? key}) : super(key: key);

  @override
  State<RegisterKendaraan> createState() => _RegisterKendaraanState();
}

class _RegisterKendaraanState extends State<RegisterKendaraan> {

  SingleValueDropDownController _jenisKendaraanController = SingleValueDropDownController();
  TextEditingController _nomorPolisiController = TextEditingController();
  TextEditingController _nomorRangkaController = TextEditingController();
  TextEditingController _namaKendaraanController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pendaftaran Kendaraan",
          style: TextStyle(color: Colors.black, fontSize: 18),),
        leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.pop(context)
        ),
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Jenis Kendaraan",
                  style: textTheme.bodyText1!.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,),
                ),
                const SizedBox(height: 10,),
                dropdownTextField(),
                const SizedBox(height: 20,),
                Text(
                  "Nama Kendaraan",
                  style: textTheme.bodyText1!.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,),
                ),
                const SizedBox(height: 10,),
                textfield(context, "Nama Kendaraan", _namaKendaraanController, TextInputType.text),
                const SizedBox(height: 20,),
                Text(
                  "Nomor Polisi",
                  style: textTheme.bodyText1!.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,),
                ),
                const SizedBox(height: 10,),
                textfield(context, "Nomor Polisi", _nomorPolisiController, TextInputType.text),
                const SizedBox(height: 20,),
                Text(
                  "Nomor Rangka",
                  style: textTheme.bodyText1!.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,),
                ),
                const SizedBox(height: 10,),
                textfield(context, "Nomor Rangka", _nomorRangkaController, TextInputType.text),
                const SizedBox(height: 20,),
                main_button("Daftar menjadi driver", context, onPressed: (){
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const InfoRegistrasiDriver(),
                    ),
                  );
                })
              ],
            ),
          ),
        ),
      ),
    );
  }

  //Widget dropdown from library dropdown_textfield
  Widget dropdownTextField() {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color: ColorValue.hintColor,
          width: 0.5,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: DropDownTextField(
          controller: _jenisKendaraanController,
          clearOption: true,
          dropDownIconProperty: IconProperty(
            icon: Icons.keyboard_arrow_down_sharp,
            color: ColorValue.neutralColor,
            size: 18,
          ),
          textFieldDecoration: InputDecoration(
            hintText: 'Pilih Jenis Kendaraan',
            hintStyle: textTheme.bodyText1!.copyWith(
              color: ColorValue.hintColor,
            ),
            border: InputBorder.none,
          ),
          textStyle: textTheme.bodyText1!.copyWith(
            color: ColorValue.neutralColor,
          ),
          searchKeyboardType: TextInputType.text,
          listTextStyle: textTheme.bodyText1!.copyWith(
            color: ColorValue.neutralColor,
          ),
          dropDownList: const [
            DropDownValueModel(name: "Kendaraan bermotor (Roda 2)", value: "Kendaraan bermotor (Roda 2)"),
            DropDownValueModel(name: "Mobil boks (pikap)", value: "Mobil boks (pikap)"),
            DropDownValueModel(name: "Truk Engkel", value: "Truk Engkel"),
            DropDownValueModel(name: "Truk Pendingin", value: "Truk Pendingin"),
          ],
          onChanged: (val) {
            print(val);
          },
        ),
      ),
    );
  }

}
