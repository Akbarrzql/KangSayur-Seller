import 'dart:io';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kangsayur_seller/bloc/bloc/register_driver_bloc.dart';
import 'package:kangsayur_seller/bloc/state/resgister_driver_state.dart';
import 'package:kangsayur_seller/repository/register_driver_repository.dart';
import 'package:kangsayur_seller/ui/informasi_driver/info_registrasi.dart';
import 'package:kangsayur_seller/ui/widget/main_button.dart';
import 'package:image/image.dart' as img;
import '../../../../bloc/event/resgiter_event.dart';
import '../../../../common/color_value.dart';
import '../../../../validator/input_validator.dart';
import '../../../widget/custom_textfield.dart';
import '../../../widget/textfiled.dart';

class RegisterKendaraan extends StatefulWidget {
  RegisterKendaraan({
    Key? key,
    required this.namaLengkap,
    required this.email,
    required this.nomorTelepon,
    required this.nomorTeleponDarurat,
    required this.password,
    required this.konfirmasiPassword,
    this.fotoDriver,
    this.fotoKTP,
    this.fotoSTNK,
    this.fotoKendaraan,
  }) : super(key: key);
  final TextEditingController namaLengkap;
  final TextEditingController email;
  final TextEditingController nomorTelepon;
  final TextEditingController nomorTeleponDarurat;
  final TextEditingController password;
  final TextEditingController konfirmasiPassword;
  File? fotoDriver;
  File? fotoKTP;
  File? fotoSTNK;
  File? fotoKendaraan;

  @override
  State<RegisterKendaraan> createState() => _RegisterKendaraanState();
}

class _RegisterKendaraanState extends State<RegisterKendaraan> {


  final SingleValueDropDownController _jenisKendaraanController = SingleValueDropDownController();
  final TextEditingController _nomorPolisiController = TextEditingController();
  final TextEditingController _nomorRangkaController = TextEditingController();
  final TextEditingController _namaKendaraanController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Future<File> compressImage(File imageFile) async {
    final tempDir = await Directory.systemTemp.createTemp();
    final tempFilePath = '${tempDir.path}/${DateTime.now().millisecondsSinceEpoch}.jpg';

    img.Image? image = img.decodeImage(imageFile.readAsBytesSync());

    while (image!.length > 2 * 1024 * 1024) {
      image = img.copyResize(image, width: image.width ~/ 2, height: image.height ~/ 2);
    }

    final compressedImageFile = File(tempFilePath)
      ..writeAsBytesSync(img.encodeJpg(image, quality: 80));

    return compressedImageFile;
  }
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return BlocProvider(
      create: (context) => RegisterDriverPageBloc(registerDriverRepository: RegisterDriverRepository()),
      child: BlocConsumer<RegisterDriverPageBloc, RegisterDriverState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is InitialRegisterDriverState){
            return buildInitialLayout(context);
          } else if(state is RegisterDriverLoading){
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is RegisterDriverSuccess){
            return buildLoadedLayout();
          } else if (state is RegisterDriverError){
            return buildInitialLayout(context);
          } else {
            return Container();
          }
        },
      )
    );
  }

  Widget buildInitialLayout(BuildContext context){
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
        child: Form(
          key: _formKey,
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
                  CustomTextFormField(
                    controller: _namaKendaraanController,
                    label: 'Nama Kendaraan',
                    validator: (value) =>  InputValidator.vehicleValidator(value),
                  ),
                  const SizedBox(height: 20,),
                  Text(
                    "Nomor Polisi",
                    style: textTheme.bodyText1!.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,),
                  ),
                  const SizedBox(height: 10,),
                  CustomTextFormField(
                    controller: _nomorPolisiController,
                    label: 'No Polisi',
                    validator: (value) =>  InputValidator.licenseValidator(value),
                  ),
                  const SizedBox(height: 20,),
                  Text(
                    "Nomor Rangka",
                    style: textTheme.bodyText1!.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,),
                  ),
                  const SizedBox(height: 10,),
                  CustomTextFormField(
                    controller: _nomorRangkaController,
                    label: 'No Rangka',
                    validator: (value) =>  InputValidator.noRangkaValidator(value),
                  ),
                  const SizedBox(height: 20,),
                  main_button("Daftar menjadi driver", context, onPressed: () async {
                    File? fotoDriver = await compressImage(widget.fotoDriver!);
                    File? fotoKTP = await compressImage(widget.fotoKTP!);
                    File? fotoSTNK = await compressImage(widget.fotoSTNK!);
                    File? fotoKendaraan = await compressImage(widget.fotoKendaraan!);

                    if(_formKey.currentState!.validate()) {
                      BlocProvider.of<RegisterDriverPageBloc>(context).add(RegisterDriverButtonPressed(
                        namaLengkap: widget.namaLengkap.text,
                        email: widget.email.text,
                        noHp: widget.nomorTelepon.text,
                        noHpDarurat: widget.nomorTeleponDarurat.text,
                        password: widget.password.text,
                        // konfirmasiPassword: widget.konfirmasiPassword.text,
                        jenisKendaraan: _jenisKendaraanController.dropDownValue!.name,
                        // namaKendaraan: _namaKendaraanController.text,
                        platNomor: _nomorPolisiController.text,
                        noRangka: _nomorRangkaController.text,
                        photoDriver: fotoDriver,
                        photoKTP: fotoKTP,
                        photoSTNK: fotoSTNK,
                        photoKendaraan: fotoKendaraan,
                      ));
                    }else{
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          backgroundColor: Colors.red,
                          margin: EdgeInsets.fromLTRB(24, 0, 24, 80),
                          behavior: SnackBarBehavior.floating,
                          content: Text("Terdapat kesalahan pada inputan"),
                        ),
                      );
                    }
                  })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildLoadedLayout() => const InfoRegistrasiDriver();

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
