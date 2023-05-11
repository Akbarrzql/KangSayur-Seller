import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kangsayur_seller/ui/widget/textfiled.dart';

import '../../common/color_value.dart';

class KustomisasiProfilePage extends StatefulWidget {
  const KustomisasiProfilePage({Key? key}) : super(key: key);

  @override
  State<KustomisasiProfilePage> createState() => _KustomisasiProfilePageState();
}

class _KustomisasiProfilePageState extends State<KustomisasiProfilePage> {

  final ImagePicker _picker = ImagePicker();
  File? _imageFile;
  File? _imageFile2;

  //text controller
  final _editNamaTokoController = TextEditingController();
  final _editDeskripsiTokoController = TextEditingController();
  final _editAlamatTokoController = TextEditingController();
  final _editNoTelpTokoController = TextEditingController();
  final _editJamBukaTokoController = TextEditingController();
  final _editJamTutupTokoController = TextEditingController();

  Future<void> _getImage(ImageSource source, int imageIndex) async {
    final pickedFile = await _picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        switch(imageIndex){
          case 1:
            _imageFile = File(pickedFile.path);
            break;
          case 2:
            _imageFile2 = File(pickedFile.path);
            break;
        }
      });
    }
  }

  Future<void> _selectTime(BuildContext context, TextEditingController controller) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null) {
      // update the text field with the selected time
      controller.text = pickedTime.format(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Kustomisasi',
          style: Theme.of(context).textTheme.headline6!.copyWith(
            color: ColorValue.neutralColor,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: Text(
              'Simpan',
              style: textTheme.headline6!.copyWith(
                color: ColorValue.primaryColor,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          )
        ],
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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                child: Stack(
                  children: [
                    //image picker here
                    Container(
                      width: double.infinity,
                      height: 100,
                      decoration: const BoxDecoration(
                        color: ColorValue.bluePricecolor,
                      ),
                      child: Stack(
                        children: [
                          GestureDetector(
                            onTap: (){
                              _showBottomSheet(context, 2);
                            },
                            child: _imageFile2 != null ? ClipRRect(
                              child: Image.file(
                                _imageFile2!,
                                width: double.infinity,
                                height: 100,
                                fit: BoxFit.cover,
                              ),
                            ) : Container()
                          ),
                          Stack(
                            children: [
                              Positioned(
                                top: 10,
                                right: 16,
                                child: CircleAvatar(
                                  radius: 16,
                                  backgroundColor: Colors.white,
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          _showBottomSheet(context, 2);
                                        },
                                        child: const Icon(
                                          Icons.edit,
                                          color: ColorValue.primaryColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 50),
                      child: Center(
                        child: Positioned(
                          child: CircleAvatar(
                            radius: 50,
                            backgroundColor: Colors.white,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    _showBottomSheet(context, 1);
                                  },
                                  child: _imageFile != null
                                      ? ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: Image.file(
                                      _imageFile!,
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                      : Container()
                                ),
                                Stack(
                                  children: [
                                    Positioned(
                                      right: 0,
                                      bottom: 0,
                                      child: CircleAvatar(
                                        radius: 16,
                                        backgroundColor: ColorValue.primaryColor,
                                        child: Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                _showBottomSheet(context, 1);
                                              },
                                              child: const Icon(
                                                Icons.camera_alt_outlined,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Nama Toko",
                      style: textTheme.headline6!.copyWith(
                        color: ColorValue.neutralColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    textfield(context, "Edit Nama Toko", _editNamaTokoController, TextInputType.text),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      "Deskripsi Toko",
                      style: textTheme.headline6!.copyWith(
                        color: ColorValue.neutralColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Container(
                  height: 150,
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
                      controller: _editDeskripsiTokoController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Edit Deskripsi Toko",
                        hintStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: ColorValue.hintColor,
                        ),
                      ),
                    ),
                  ),
                ),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      "Alamat Toko",
                      style: textTheme.headline6!.copyWith(
                        color: ColorValue.neutralColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Container(
                      height: 150,
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
                      controller: _editAlamatTokoController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Edit Alamat Toko",
                        hintStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: ColorValue.hintColor,
                        ),
                      ),
                    ),
                  ),
                ),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      "Nomor Telepon",
                      style: textTheme.headline6!.copyWith(
                        color: ColorValue.neutralColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    textfield(context, "Edit Nomor Telepon", _editNoTelpTokoController, TextInputType.number),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      "Jam Operasional",
                      style: textTheme.headline6!.copyWith(
                        color: ColorValue.neutralColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 50,
                            width: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: ColorValue.hintColor,
                                width: 0.5,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: TextFormField(
                                controller: _editJamBukaTokoController,
                                keyboardType: TextInputType.text,
                                onTap: (){
                                  _selectTime(context, _editJamBukaTokoController);
                                },
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Jam Buka",
                                  hintStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
                                    color: ColorValue.hintColor,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 30,
                          child: Divider(
                            color: ColorValue.hintColor,
                            thickness: 1,
                            endIndent: 5,
                            indent: 5,
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 50,
                            width: 100,
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
                                controller: _editJamTutupTokoController,
                                keyboardType: TextInputType.text,
                                onTap: (){
                                  _selectTime(context, _editJamTutupTokoController);
                                },
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Jam Tutup",
                                  hintStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
                                    color: ColorValue.hintColor,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  //show bottom sheet
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
