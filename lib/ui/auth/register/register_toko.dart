import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kangsayur_seller/common/color_value.dart';
import 'package:kangsayur_seller/ui/auth/register/kategori_toko.dart';
import 'package:kangsayur_seller/ui/auth/register/list_operasional_toko.dart';
import 'package:kangsayur_seller/ui/auth/register/map_page.dart';
import 'package:kangsayur_seller/ui/auth/register/register_pemilik.dart';
import '../../widget/textfiled.dart';

class register_toko extends StatefulWidget {
  const register_toko({Key? key, required this.selectedCategoriesOperasional}) : super(key: key);
  final List<bool> selectedCategoriesOperasional;

  @override
  State<register_toko> createState() => _register_tokoState();
}

class _register_tokoState extends State<register_toko> {
  final _namaTokoController = TextEditingController();
  final _deskripsiController = TextEditingController();
  final _alamatController = TextEditingController();

  final ImagePicker _picker = ImagePicker();
  File? _imageFile;
  bool _isCategorySelectedOperasional = false;

  Future<void> _getImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  Future<void> _selectTime(
      BuildContext context, TextEditingController controller) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null) {
      // update the text field with the selected time
      controller.text = pickedTime.format(context);
    }
  }

  List<String> categoryHari = [
    "Senin",
    "Selasa",
    "Rabu",
    "Kamis",
    "Jumat",
    "Sabtu",
    "Setiap Hari"
  ];

  //list controller
  final List<TextEditingController> _jamBukaOperasionalController = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController()
  ];

  final List<TextEditingController> _jamTutupOperasionalController = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController()
  ];


  @override
  void initState() {
    super.initState();
    // Check if any category is already selected
    for (var i = 0; i < widget.selectedCategoriesOperasional.length; i++) {
      if (widget.selectedCategoriesOperasional[i]) {
        _isCategorySelectedOperasional = true;
        break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Pendaftaran Toko",
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const register_pemilik()),
                  (Route<dynamic> route) => false),
        ),
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Foto Toko",
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
              //informasi banner
              const SizedBox(
                height: 20,
              ),
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
                        "Nama toko tidak dapat diubah setelah lapak terverifikasi.",
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
                "Nama Toko",
                style: Theme.of(context).textTheme.subtitle1!.copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: ColorValue.neutralColor,
                    ),
              ),
              const SizedBox(
                height: 10,
              ),
              textfield(context, "Nama toko", _namaTokoController, TextInputType.name),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Deskripsi Toko",
                style: Theme.of(context).textTheme.subtitle1!.copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: ColorValue.neutralColor,
                    ),
              ),
              const SizedBox(
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
                    controller: _deskripsiController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Deksripsi toko",
                      hintStyle:
                          Theme.of(context).textTheme.bodyText1!.copyWith(
                                color: ColorValue.hintColor,
                              ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Alamat Toko",
                style: Theme.of(context).textTheme.subtitle1!.copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: ColorValue.neutralColor,
                    ),
              ),
              const SizedBox(
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
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Alamat toko",
                      hintStyle:
                          Theme.of(context).textTheme.bodyText1!.copyWith(
                                color: ColorValue.hintColor,
                              ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Jam Operasional",
                style: Theme.of(context).textTheme.subtitle1!.copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: ColorValue.neutralColor,
                    ),
              ),
              const SizedBox(
                height: 10,
              ),
              if(_isCategorySelectedOperasional)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (var i = 0; i < widget.selectedCategoriesOperasional.length; i++)
                      if(widget.selectedCategoriesOperasional[i])
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              categoryHari[i],
                              style: Theme.of(context).textTheme.subtitle1!.copyWith(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: ColorValue.neutralColor,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
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
                                        controller: _jamBukaOperasionalController[i],
                                        keyboardType: TextInputType.text,
                                        onTap: (){
                                          _selectTime(context, _jamBukaOperasionalController[i]);
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
                                        controller: _jamTutupOperasionalController[i],
                                        keyboardType: TextInputType.text,
                                        onTap: (){
                                          _selectTime(context, _jamTutupOperasionalController[i]);
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
                            const SizedBox(
                              height: 20,
                            ),
                          ],
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
                            builder: (context) => const ListOperasionalToko()));
                  },
                  child: Text(
                    "Pilih Jam Operasional",
                    style: Theme.of(context).textTheme.subtitle1!.copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                ),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MapScreen(),
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
