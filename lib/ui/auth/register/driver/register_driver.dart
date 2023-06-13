import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kangsayur_seller/ui/informasi_driver/list_driver.dart';
import 'package:kangsayur_seller/ui/auth/register/driver/register_kendaraan.dart';
import 'package:kangsayur_seller/ui/widget/main_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../common/color_value.dart';
import '../../../widget/textfiled.dart';

class RegisterDriver extends StatefulWidget {
  const RegisterDriver({Key? key}) : super(key: key);

  @override
  State<RegisterDriver> createState() => _RegisterDriverState();
}

class _RegisterDriverState extends State<RegisterDriver> {

  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _noHpController = TextEditingController();
  TextEditingController _noHpDaruratController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  final ImagePicker _picker = ImagePicker();
  File? _imageFile;

  Future<void> _getImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  Future<bool> hasRegisteredBefore() async {
    //shared preferences set if user has registered before
    SharedPreferences pref = await SharedPreferences.getInstance();
    bool? hasRegistered = pref.getBool('hasRegistered');
    if (hasRegistered == null) {
      return false;
    } else {
      return hasRegistered;
    }
  }


  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pendaftaran Driver",
          style: TextStyle(color: Colors.black, fontSize: 18),),
        leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.pop(context)
        ),
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                          "Setelah mendaftar kamu akan tetap bisa menambah atau mengubah data diri driver.",
                          style: Theme.of(context).textTheme.subtitle1!.copyWith(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: ColorValue.primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Foto Driver",
                  style: Theme.of(context).textTheme.subtitle1!.copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color: ColorValue.neutralColor,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                //image picker
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        _showBottomSheet(context);
                      },
                      child: Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          color: ColorValue.neutralColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: _imageFile != null ? ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.file(_imageFile!, fit: BoxFit.cover),
                        ) : Container(
                          decoration: BoxDecoration(
                            color: ColorValue.neutralColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(Icons.add_a_photo_outlined, color: ColorValue.primaryColor,),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          width: 15,
                        ),
                        Text(
                          "Unggah Foto Driver",
                          style: Theme.of(context).textTheme.subtitle1!.copyWith(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: ColorValue.neutralColor,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        //kondisi jika foto sudah di upload maka akan menampilkan button upload ulanng
                        _imageFile != null ? ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: ColorValue.primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          onPressed: (){
                            _showBottomSheet(context);
                          },
                          child: Text(
                            "Unggah Ulang",
                            style: Theme.of(context).textTheme.subtitle1!.copyWith(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                        ) : Container(),
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 20,),
                Text(
                  "Nama Lengkap",
                  style: textTheme.bodyText1!.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,),
                ),
                const SizedBox(height: 10,),
                textfield(context, "Masukkan Nama Lengkap", _nameController, TextInputType.text),
                const SizedBox(height: 20,),
                Text(
                  "Email",
                  style: textTheme.bodyText1!.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,),
                ),
                const SizedBox(height: 10,),
                textfield(context, "Masukkan Email", _emailController, TextInputType.emailAddress),
                const SizedBox(height: 20,),
                Text(
                  "No. HP",
                  style: textTheme.bodyText1!.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,),
                ),
                const SizedBox(height: 10,),
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
                const SizedBox(height: 20,),
                Text(
                  "No. HP Darurat",
                  style: textTheme.bodyText1!.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,),
                ),
                const SizedBox(height: 10,),
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
                      controller: _noHpDaruratController,
                      keyboardType: TextInputType.phone,
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
                        hintText: "Masukkan No. HP Darurat",
                        hintStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: ColorValue.hintColor,
                        ),
                      ),
                    ),

                  ),
                ),
                const SizedBox(height: 20,),
                Text(
                  "Password",
                  style: textTheme.bodyText1!.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,),
                ),
                const SizedBox(height: 10,),
                textfield(context, "Masukkan Password", _passwordController, TextInputType.text),
                const SizedBox(height: 20,),
                Text(
                  "Konfirmasi Password",
                  style: textTheme.bodyText1!.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,),
                ),
                const SizedBox(height: 10,),
                textfield(context, "Masukkan Konfirmasi Password", _confirmPasswordController, TextInputType.text),
                const SizedBox(height: 20,),
                main_button("Selanjutnya", context, onPressed: () async {
                  SharedPreferences.getInstance().then((prefs) {
                    prefs.setBool('hasRegistered', true);
                  });
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RegisterKendaraan(),
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: 150,
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                Text(
                  "Pilih Foto",
                  style: Theme.of(context).textTheme.subtitle1!.copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color: ColorValue.neutralColor,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        _getImage(ImageSource.camera);
                        Navigator.pop(context);
                      },
                      child: Column(
                        children: [
                          const Icon(
                            Icons.camera_alt_outlined,
                            color: ColorValue.primaryColor,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Kamera",
                            style:
                            Theme.of(context).textTheme.subtitle1!.copyWith(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: ColorValue.neutralColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        _getImage(ImageSource.gallery);
                        Navigator.pop(context);
                      },
                      child: Column(
                        children: [
                          const Icon(
                            Icons.photo_outlined,
                            color: ColorValue.primaryColor,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Galeri",
                            style:
                            Theme.of(context).textTheme.subtitle1!.copyWith(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: ColorValue.neutralColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }
}
