import 'dart:io';

import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kangsayur_seller/ui/produk/tambah_produk.dart';
import 'package:kangsayur_seller/ui/widget/main_button.dart';

import '../../common/color_value.dart';
import '../widget/textfiled.dart';

class TambahVariantPage extends StatefulWidget {
  const TambahVariantPage({Key? key}) : super(key: key);

  @override
  State<TambahVariantPage> createState() => _TambahVariantPageState();
}

class _TambahVariantPageState extends State<TambahVariantPage> {

  final ImagePicker _picker = ImagePicker();
  File? _imageFile;
  File? _imageFile2;
  File? _imageFile3;
  File? _imageFile4;

  final TextEditingController _namaVarianController = TextEditingController();
  final TextEditingController _deksripsiController = TextEditingController();
  final TextEditingController _stokVarianController = TextEditingController();
  final TextEditingController _hargaVarianController = TextEditingController();

  final _formatter = CurrencyTextInputFormatter(
    locale: 'id',
    decimalDigits: 0,
    symbol: 'Rp. ',
  );

  Future<void> _getImage(ImageSource source,  int imageIndex) async {
    final pickedFile = await _picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        switch (imageIndex) {
          case 1:
            _imageFile = File(pickedFile.path);
            break;
          case 2:
            _imageFile2 = File(pickedFile.path);
            break;
          case 3:
            _imageFile3 = File(pickedFile.path);
            break;
          case 4:
            _imageFile4 = File(pickedFile.path);
            break;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Buat Produk Baru',
          style: Theme.of(context).textTheme.headline6!.copyWith(
            color: ColorValue.neutralColor,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: ColorValue.neutralColor,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: const Color(0xffD7FEDF),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  height: 45,
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
                          "Unggah foto produk yang akan dijual",
                          style: Theme.of(context).textTheme.subtitle1!.copyWith(
                            fontWeight: FontWeight.w500,
                            fontSize: 10,
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
                  "Foto Produk",
                  style: textTheme.subtitle1!.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    color: ColorValue.neutralColor,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: (){
                        _showBottomSheet(context, 1);
                      },
                      child: Container(
                        height: 65,
                        width: 65,
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
                    GestureDetector(
                      onTap: (){
                        _showBottomSheet(context, 2);
                      },
                      child: Container(
                        height: 65,
                        width: 65,
                        decoration: BoxDecoration(
                          color: ColorValue.neutralColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: _imageFile2 != null ? ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.file(_imageFile2!, fit: BoxFit.cover),
                        ) : Container(
                          decoration: BoxDecoration(
                            color: ColorValue.neutralColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(Icons.add_a_photo_outlined, color: ColorValue.primaryColor,),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        _showBottomSheet(context, 3);
                      },
                      child: Container(
                        height: 65,
                        width: 65,
                        decoration: BoxDecoration(
                          color: ColorValue.neutralColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: _imageFile3 != null ? ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.file(_imageFile3!, fit: BoxFit.cover),
                        ) : Container(
                          decoration: BoxDecoration(
                            color: ColorValue.neutralColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(Icons.add_a_photo_outlined, color: ColorValue.primaryColor,),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        _showBottomSheet(context, 4);
                      },
                      child: Container(
                        height: 65,
                        width: 65,
                        decoration: BoxDecoration(
                          color: ColorValue.neutralColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: _imageFile4 != null ? ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.file(_imageFile4!, fit: BoxFit.cover),
                        ) : Container(
                          decoration: BoxDecoration(
                            color: ColorValue.neutralColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(Icons.add_a_photo_outlined, color: ColorValue.primaryColor,),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Nama Varian",
                  style: textTheme.subtitle1!.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    color: ColorValue.neutralColor,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                textfield(context, "Masukkan Nama Produk", _namaVarianController, TextInputType.text),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Deskripsi Varian",
                  style: textTheme.subtitle1!.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    color: ColorValue.neutralColor,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                textfield(context, "Masukkan Deskripsi Produk", _deksripsiController, TextInputType.text),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Stok Varian",
                  style: textTheme.subtitle1!.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    color: ColorValue.neutralColor,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                textfield(context, "Masukkan Stok Produk", _stokVarianController, TextInputType.number),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Harga Varian",
                  style: textTheme.subtitle1!.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    color: ColorValue.neutralColor,
                  ),
                ),
                const SizedBox(
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
                      controller: _hargaVarianController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [_formatter],
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Rp. ",
                        hintStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: ColorValue.hintColor,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                main_button("Tambah Varian", context, onPressed: () {
                  String namaVarian = _namaVarianController.text;
                  String deskripsiVarian = _deksripsiController.text;
                  String hargaVarian = _hargaVarianController.text.replaceAll('Rp. ', '').replaceAll('.', '').toString();
                  String stokVarian = _stokVarianController.text;

                  Map<String, dynamic> variant = {
                    'images': _imageFile != null ? _imageFile!.path : null,
                    'variant': namaVarian,
                    'variant_desc': deskripsiVarian,
                    'stok': stokVarian,
                    'harga_variant': hargaVarian,
                  };

                  print(variant);
                  Navigator.pop(context, variant);
                },)
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showBottomSheet(BuildContext context, int imageIndex) {
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
                        _getImage(ImageSource.camera, imageIndex);
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
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1!
                                .copyWith(
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
                        _getImage(ImageSource.gallery, imageIndex);
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
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1!
                                .copyWith(
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