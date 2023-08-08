import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kangsayur_seller/bloc/bloc/add_iklan_bloc.dart';
import 'package:kangsayur_seller/repository/iklan_repository.dart';
import 'package:kangsayur_seller/ui/iklan/kategori_iklan.dart';
import 'package:kangsayur_seller/ui/informasi/informasi.dart';
import 'package:kangsayur_seller/ui/widget/main_button.dart';
import 'package:kangsayur_seller/ui/widget/textfiled.dart';

import '../../bloc/event/add_iklan_event.dart';
import '../../bloc/state/add_iklan_state.dart';
import '../../common/color_value.dart';
import 'package:image/image.dart' as img;

class IklanPage extends StatefulWidget {
  const IklanPage({Key? key, required this.selectedCategories})
      : super(key: key);
  final List<bool> selectedCategories;

  @override
  State<IklanPage> createState() => _IklanPageState();
}

class _IklanPageState extends State<IklanPage> {
  final ImagePicker _picker = ImagePicker();
  File? _imageFile;
  final _judulIklanController = TextEditingController();
  bool _isCategorySelected = false;
  bool _iskategoriIklanSelected = false;
  bool _iskategoriIklanSelected1 = false;

  Future<void> _getImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  List<String> categoryNames = [
    "Bahan Pokok",
    "Sayuran",
    "Buah Buahan",
    "Daging",
    "Unggas",
    "Telur"
  ];
  List<String> categoryIcons = [
    "assets/svg/bahan_pokok.svg",
    "assets/svg/sayuran_1.svg",
    "assets/svg/buah.svg",
    "assets/svg/daging.svg",
    "assets/svg/unggas.svg",
    "assets/svg/telur.svg"
  ];

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
  void initState() {
    super.initState();

    for (int i = 0; i < widget.selectedCategories.length; i++) {
      if (widget.selectedCategories[i]) {
        setState(() {
          _isCategorySelected = true;
          _iskategoriIklanSelected = true;
        });
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
          'Iklan',
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
      body: BlocProvider(
        create: (context) => IklanBloc(iklanRepository: IklanRepository()),
        child: BlocConsumer<IklanBloc, AddIklanState>(
          listener: (context, state) {},
          builder: (context, state) {
            if(state is InitialAddIklanState){
              return buildInitailLayout(context);
            } else if (state is AddIklanPageLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is AddIklanPageLoaded) {
              return const InformasiIklanPage();
            } else {
              return const Center(
                child: Text("Error"),
              );
            }
          },
        )
      )
    );
  }

  Widget buildInitailLayout(BuildContext context){
    final textTheme = Theme.of(context).textTheme;
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
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
            const SizedBox(
              height: 10,
            ),
            Text(
              "Foto Banner Iklan",
              style: Theme.of(context).textTheme.subtitle1!.copyWith(
                fontWeight: FontWeight.w500,
                fontSize: 14,
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
                    child: _imageFile != null
                        ? ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.file(_imageFile!, fit: BoxFit.cover),
                    )
                        : Container(
                      decoration: BoxDecoration(
                        color: ColorValue.neutralColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(
                        Icons.add_a_photo_outlined,
                        color: ColorValue.primaryColor,
                      ),
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
                    _imageFile != null
                        ? ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: ColorValue.primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      onPressed: () {
                        _showBottomSheet(context);
                      },
                      child: Text(
                        "Unggah Ulang",
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1!
                            .copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                    )
                        : Container(),
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Nama Iklan Toko",
              style: Theme.of(context).textTheme.subtitle1!.copyWith(
                fontWeight: FontWeight.w500,
                fontSize: 14,
                color: ColorValue.neutralColor,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            textfield(context, "Nama Iklan", _judulIklanController,
                TextInputType.text),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Pilih Kateogri Iklan",
              style: Theme.of(context).textTheme.subtitle1!.copyWith(
                fontWeight: FontWeight.w500,
                fontSize: 14,
                color: ColorValue.neutralColor,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ActionChip(
                  label: Text(
                    "Iklan Katalog",
                    style: textTheme.bodyText2!.copyWith(
                      color: _iskategoriIklanSelected
                          ? Colors.white
                          : ColorValue.neutralColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      _iskategoriIklanSelected = true;
                      _iskategoriIklanSelected1 = false;
                    });
                  },
                  backgroundColor: _iskategoriIklanSelected
                      ? ColorValue.primaryColor
                      : ColorValue.neutralColor.withOpacity(0.1),
                  elevation: 2,
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  labelPadding: const EdgeInsets.symmetric(vertical: 5),
                  visualDensity: VisualDensity.compact,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                ActionChip(
                  label: Text(
                    "Iklan Toko",
                    style: textTheme.bodyText2!.copyWith(
                      color: _iskategoriIklanSelected1
                          ? Colors.white
                          : ColorValue.neutralColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      _iskategoriIklanSelected1 = true;
                      _iskategoriIklanSelected = false;
                    });
                  },
                  backgroundColor: _iskategoriIklanSelected1
                      ? ColorValue.primaryColor
                      : ColorValue.neutralColor.withOpacity(0.1),
                  elevation: 2,
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  labelPadding: const EdgeInsets.symmetric(vertical: 5),
                  visualDensity: VisualDensity.compact,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ],
            ),
            _iskategoriIklanSelected
                ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Kategori Toko",
                  style:
                  Theme.of(context).textTheme.subtitle1!.copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color: ColorValue.neutralColor,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                if (_isCategorySelected)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (var i = 0;
                      i < widget.selectedCategories.length;
                      i++)
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
                                          borderRadius:
                                          BorderRadius.circular(5),
                                          color:
                                          ColorValue.primaryColor,
                                        ),
                                      ),
                                      SvgPicture.asset(
                                        categoryIcons[i],
                                        width: 30,
                                        height: 30,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  Text(
                                    categoryNames[i],
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle1!
                                        .copyWith(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                      color:
                                      ColorValue.neutralColor,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              )
                            ],
                          ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: ColorValue.primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            _isCategorySelected = false;
                          });
                        },
                        child: Text(
                          "Batal",
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1!
                              .copyWith(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                      ),
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
                              builder: (context) => const KategoriIklan()));
                    },
                    child: Text(
                      "Pilih Kategori Iklan",
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1!
                          .copyWith(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                  ),
              ],
            )
                : Container(),
            const SizedBox(
              height: 20,
            ),
            _isCategorySelected ? main_button('Iklankan', context, onPressed: () async{
              File? selectedImage = await compressImage(_imageFile!);
              BlocProvider.of<IklanBloc>(context).add(
                  PostIklan(
                    imgPamflet: selectedImage,
                    kategoriId: widget.selectedCategories.indexOf(true) + 1,
                  ));
            }) : main_button('Iklankan', context, onPressed: () {}),
          ],
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
class Kategori {
  final String kategori;
  bool isSelected;

  Kategori(this.kategori, this.isSelected);
}

