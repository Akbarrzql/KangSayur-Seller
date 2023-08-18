import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kangsayur_seller/bloc/bloc/edit_seller_bloc.dart';
import 'package:kangsayur_seller/bloc/state/edit_driver_state.dart';
import 'package:kangsayur_seller/ui/informasi_driver/informasi_driver.dart';

import '../../bloc/bloc/edit_driver_bloc.dart';
import '../../bloc/event/edit_driver_event.dart';
import '../../common/color_value.dart';
import '../../model/list_all_driver_model.dart';
import '../../repository/edit_driver_repository.dart';

class EditInformasiDriver extends StatefulWidget {
  const EditInformasiDriver({Key? key, required this.data}) : super(key: key);
  final Produk data;

  @override
  State<EditInformasiDriver> createState() => _EditInformasiDriverState();
}

class _EditInformasiDriverState extends State<EditInformasiDriver> {
  final ImagePicker _picker = ImagePicker();
  File? _imageFile;

  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _kendaraanController = TextEditingController();
  TextEditingController _platController = TextEditingController();

  Future<void> _getImage(ImageSource source, int imageIndex) async {
    final pickedFile = await _picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return BlocProvider(
      create: (context) => EditDriverPageBloc(editDriverPageRepository: EditDriverRepository()),
      child: BlocConsumer<EditDriverPageBloc, EditDriverState>(
        listener: (context, state) {},
        builder: (context, state) {
          if(state is EditDriverInitial){
            return Scaffold(
              backgroundColor: const Color(0xFF0E4F55),
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                actions: [
                  InkWell(
                    onTap: (){
                      if(_imageFile != null) {
                        BlocProvider.of<EditDriverPageBloc>(context).add(EditDriver(
                          widget.data.driverId.toString(),
                          _nameController.text,
                          _imageFile,
                          _phoneController.text,
                          _platController.text,
                          _kendaraanController.text,
                        ));
                      }else if (_imageFile == null){
                        BlocProvider.of<EditDriverPageBloc>(context).add(EditDriver(
                          widget.data.driverId.toString(),
                          _nameController.text,
                          null,
                          _phoneController.text,
                          _platController.text,
                          _kendaraanController.text,
                        ));
                      }
                    },
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Text(
                        'Simpan',
                        style: textTheme.headline6!.copyWith(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              body: SafeArea(
                child: SingleChildScrollView(
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 60, 0, 0),
                        child: Expanded(
                          child: Container(
                            height: MediaQuery.of(context).size.height,
                            width: double.infinity,
                            padding:
                            const EdgeInsets.symmetric(horizontal: 28, vertical: 50),
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(25),
                                    topRight: Radius.circular(25))),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _listData("Nama Driver", widget.data.namaDriver.toString(), _nameController, TextInputType.text),
                                const SizedBox(height: 20,),
                                _listData("No Telepon", "+62${widget.data.nomorTelfon.toString()}", _phoneController, TextInputType.phone),
                                const SizedBox(height: 20,),
                                _listData("Nama Kendaraan", widget.data.namaKendaraan.toString(), _kendaraanController, TextInputType.text),
                                const SizedBox(height: 20,),
                                _listData("No Polisi", widget.data.nomorPolisi.toString(), _platController, TextInputType.text),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        child: CircleAvatar(
                          radius: 50,
                          backgroundImage: NetworkImage('https://kangsayur.nitipaja.online${widget.data.fotoDriver.toString()}'),
                          child: Stack(
                            alignment: Alignment.topCenter,
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
                                      : Container()),
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
                    ],
                  ),
                ),
              ),
            );
          }else if (state is EditDriverLoading){
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }else if (state is EditDriverSuccess){
            return DetailInformasiDriverPage(
              data: widget.data,
            );
          }else if(state is EditDriverError){
            return Scaffold(
              body: Center(
                child: Column(
                  children: [
                    const Text('Gagal mengupdate data'),
                    const SizedBox(height: 20,),
                    ElevatedButton(
                      onPressed: (){
                        Navigator.pop(context);
                      },
                      child: const Text('Kembali'),
                    ),
                  ],
                ),
              ),
            );
          }else{
            return Scaffold(
              body: Center(
                child: Column(
                  children: [
                    const Text('Gagal mengupdate data'),
                    const SizedBox(height: 20,),
                    ElevatedButton(
                      onPressed: (){
                        Navigator.pop(context);
                      },
                      child: const Text('Kembali'),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }

  Widget _listData(String tittle, String hinrText, TextEditingController textEditingController, TextInputType keyboardType) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            tittle,
            style: textTheme.headline6!.copyWith(
              color: ColorValue.neutralColor,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xFFF5F5F5),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                controller: textEditingController,
                keyboardType: keyboardType,
                textInputAction: TextInputAction.next,
                style: textTheme.bodyText2!.copyWith(
                  color: ColorValue.neutralColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: hinrText,
                  hintStyle: textTheme.bodyText2!.copyWith(
                    color: ColorValue.neutralColor.withOpacity(0.5),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        ],
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
