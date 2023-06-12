import 'dart:io';

import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kangsayur_seller/ui/informasi/informasi_tambah_produk.dart';
import 'package:kangsayur_seller/ui/widget/dialog_alret.dart';
import 'package:kangsayur_seller/ui/widget/main_button.dart';
import 'package:kangsayur_seller/ui/widget/textfiled.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../common/color_value.dart';

class TambahProdukPage extends StatefulWidget {
  const TambahProdukPage({Key? key}) : super(key: key);

  @override
  State<TambahProdukPage> createState() => _TambahProdukPageState();
}

class _TambahProdukPageState extends State<TambahProdukPage> {

  final ImagePicker _picker = ImagePicker();
  File? _imageFile;
  File? _imageFile2;
  File? _imageFile3;
  File? _imageFile4;

  bool withInputFormatter = false;
  bool _isKetentuanSelected = false;
  bool _isLoaded = false;

  //text controller
  final _namaProdukController = TextEditingController();
  final _deskripsiController = TextEditingController();
  final _hargaController = TextEditingController();
  final _stokController = TextEditingController();
  final _variantController = TextEditingController();

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

  final List<Kategori> _listKategori = [
    Kategori('Sayuran', false),
    Kategori('Unggas', false),
    Kategori('Bahan Pokok', false),
    Kategori('Buah-Buahan', false),
    Kategori('Daging', false),
    Kategori('Telur', false),
  ];

  final List<String> _katalogIcons = [
    "assets/svg/sayuran_1.svg",
    "assets/svg/unggas.svg",
    "assets/svg/bahan_pokok.svg",
    "assets/svg/buah.svg",
    "assets/svg/daging.svg",
    "assets/svg/telur.svg",
  ];

  List<String> _chipsList = [];

  final _formatter = CurrencyTextInputFormatter(
    locale: 'id',
    decimalDigits: 0,
    symbol: 'Rp. ',
  );

  Future _addProduct() async {

    setState(() {
      _isLoaded = false;
    });

    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('token');
    var url = Uri.parse('https://kangsayur.nitipaja.online/api/seller/produk/create');
    var response = await http.post(url,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        }
        ,body: {
          'nama_produk': _namaProdukController.text,
          'deskripsi': _deskripsiController.text,
          'harga_produk': _hargaController.text.replaceAll('Rp. ', '').replaceAll('.', '').toString(),
          'kategori_id': _listKategori.indexWhere((element) => element.isSelected).toString(),
          'stok_produk': _stokController.text.toString(),
        });

    print(response.body);
    print(response.statusCode);

    if (response.statusCode == 200) {
      setState(() {
        _isLoaded = true;
      });
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            child: Container(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Berhasil",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "Produk berhasil ditambahkan",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 24),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const InformasiVerifikasiProduk(),
                        ),
                      );
                    },
                    child: const Text(
                      "OK",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      );
    } else {
      setState(() {
        _isLoaded = true;
      });
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            child: Container(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Gagal",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "Gagal menambahkan produk",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 24),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "OK",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      );
    }

    setState(() {
      _isLoaded = true;
    });
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
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
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
                "Nama Produk",
                style: textTheme.subtitle1!.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                  color: ColorValue.neutralColor,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              textfield(context, "Masukkan Nama Produk", _namaProdukController, TextInputType.text),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Deksripsi Produk",
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
                height: 170,
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
                    controller: _deskripsiController,
                    textInputAction: TextInputAction.newline,
                    minLines: 10,
                    maxLines: 10000,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Masukkan Deksripsi Produk",
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
              Text(
                "Katalog Produk",
                style: textTheme.subtitle1!.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                  color: ColorValue.neutralColor,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              GridView.builder(
                shrinkWrap: true,
                itemCount: 6,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 2,
                ),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: (){
                      setState(() {
                        _listKategori[index].isSelected = !_listKategori[index].isSelected;
                      });
                    },
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        color: _listKategori[index].isSelected ? ColorValue.primaryColor : const Color(0xFFB3B3B4),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Text(
                                _listKategori[index].kategori,
                                style: textTheme.bodyText1!.copyWith(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                  color: _listKategori[index].isSelected ? Colors.white : Colors.white,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Stack(
                              children: [
                                //circle container white and icon svg
                                Container(
                                  padding: const EdgeInsets.all(2),
                                  height: 42,
                                  width: 42,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: Container(
                                    padding: const EdgeInsets.all(5),
                                    child: SvgPicture.asset(
                                      _katalogIcons[index],
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      )
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Harga Produk",
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
                    controller: _hargaController,
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
              Text(
                "Stok Produk",
                style: textTheme.subtitle1!.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                  color: ColorValue.neutralColor,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              textfield(context, "Jumlah Stock Produk", _stokController, TextInputType.number),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Varian (Opsional)",
                style: textTheme.subtitle1!.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                  color: ColorValue.neutralColor,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Wrap(
                spacing: 10,
                children: _getChips(),
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
                    controller: _variantController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Enter chip text",
                      hintStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
                        color: ColorValue.hintColor,
                      ),
                    ),
                    onFieldSubmitted: (String value) {
                      if (value.isNotEmpty) {
                        setState(() {
                          _chipsList.add(value);
                          _variantController.clear();
                        });
                      }
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 20,
                    width: 20,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        color: ColorValue.hintColor,
                        width: 0.5,
                      ),
                    ),
                    child: Checkbox(
                      value: _isKetentuanSelected,
                      onChanged: (value) {
                        setState(() {
                          _isKetentuanSelected = value!;
                        });
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Menyetujui",
                            style: textTheme.bodyText1!.copyWith(
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                              color: ColorValue.neutralColor,
                            ),
                          ),
                          const TextSpan(
                            text: " ",
                          ),
                          TextSpan(
                            text: "ketentuan menambah produk",
                            style: textTheme.bodyText1!.copyWith(
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                              color: ColorValue.primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              main_button("Tambah Produk", context, onPressed: (){
                //if checkbox is checked then navigate to next page
                if(_isKetentuanSelected){
                  _addProduct();
                }
                else{
                  showErrorDialog(
                    context,
                    "Anda belum menyetujui ketentuan menambah produk",
                    "Ketentuan Menambah Produk",
                  );
                }
              })
            ],
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

  List<Widget> _getChips() {
    List<Widget> chips = [];

    for (String chipText in _chipsList) {
      chips.add(
        Chip(
          label: Text(
              chipText,
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                color: Colors.white,
              ),
            textAlign: TextAlign.center,
          ),
          onDeleted: () {
            setState(() {
              _chipsList.remove(chipText);
            });
          },
          backgroundColor: ColorValue.primaryColor,
          deleteIconColor: Colors.white,
        ),
      );
    }

    return chips;
  }
}

class Kategori {
  final String kategori;
  bool isSelected;

  Kategori(this.kategori, this.isSelected);
}
