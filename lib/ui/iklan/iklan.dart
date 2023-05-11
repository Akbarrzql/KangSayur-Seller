import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kangsayur_seller/ui/iklan/kategori_iklan.dart';
import 'package:kangsayur_seller/ui/informasi/informasi.dart';
import 'package:kangsayur_seller/ui/widget/main_button.dart';
import 'package:kangsayur_seller/ui/widget/textfiled.dart';

import '../../common/color_value.dart';
import '../auth/register/kategori_toko.dart';

class IklanPage extends StatefulWidget {
  const IklanPage({Key? key, required this.selectedCategories}) : super(key: key);
  final List<bool> selectedCategories;

  @override
  State<IklanPage> createState() => _IklanPageState();
}

class _IklanPageState extends State<IklanPage> {

  final ImagePicker _picker = ImagePicker();
  File? _imageFile;
  final _judulIklanController = TextEditingController();
  bool _isCategorySelected = false;


  Future<void> _getImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  List<String> categoryNames = [    "Bahan Pokok",    "Sayuran",    "Buah Buahan",    "Daging",    "Unggas",    "Telur"  ];
  List<String> categoryIcons = [
    "assets/svg/bahan_pokok.svg",
    "assets/svg/sayuran_1.svg",
    "assets/svg/buah.svg",
    "assets/svg/daging.svg",
    "assets/svg/unggas.svg",
    "assets/svg/telur.svg"
  ];

  @override
  void initState() {
    super.initState();

    // Check if any category is already selected
    for (var i = 0; i < widget.selectedCategories.length; i++) {
      if (widget.selectedCategories[i]) {
        _isCategorySelected = true;
        break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Pemasukan',
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
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
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
                        "Untuk bisa menampilkan iklan kamu harus dengan format lebar 250 & tinggi 94 ",
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
              const SizedBox(height: 10,),
              Text(
                "Foto Banner Iklan",
                style: Theme.of(context).textTheme.subtitle1!.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: ColorValue.neutralColor,
                ),
              ),
              const SizedBox(height: 10,),
              //image picker
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: (){
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
                        "Unggah Foto Toko",
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
                "Nama Iklan Toko",
                style: Theme.of(context).textTheme.subtitle1!.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: ColorValue.neutralColor,
                ),
              ),
              const SizedBox(height: 10,),
              textfield(context, "Nama Iklan", _judulIklanController, TextInputType.text),
              const SizedBox(height: 20,),
              Text(
                "Kategori Toko",
                style: Theme.of(context).textTheme.subtitle1!.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: ColorValue.neutralColor,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              if (_isCategorySelected)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (var i = 0; i < widget.selectedCategories.length; i++)
                      if (widget.selectedCategories[i])
                        Column(
                          children: [
                            Row(
                              children: [
                                Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Container(
                                      width: 50,
                                      height: 50,
                                      //border radius
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: ColorValue.primaryColor,
                                      ),
                                    ),
                                    SvgPicture.asset(
                                      categoryIcons[i],
                                      width: 30,
                                      height: 30,
                                    ),
                                  ],
                                ),
                                SizedBox(width: 15,),
                                Text(
                                  categoryNames[i],
                                  style: Theme.of(context).textTheme.subtitle1!.copyWith(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    color: ColorValue.neutralColor,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10,)
                          ],
                        )
                  ],
                )
              else
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: ColorValue.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => KategoriIklan()));
                  },
                  child: Text(
                    "Pilih Kategori Iklan",
                    style: Theme.of(context).textTheme.subtitle1!.copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                ),
              const SizedBox(height: 20,),
              main_button("Iklankan", context, onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => InformasiIklanPage()));
              })
            ],
          ),
        ),
      ),
    );
  }


  //show bottom sheet
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
