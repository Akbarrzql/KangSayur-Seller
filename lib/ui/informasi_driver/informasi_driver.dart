import 'package:flutter/material.dart';

import '../../common/color_value.dart';
import '../../model/list_all_driver_model.dart';
import 'edit_informasi_driver.dart';

class DetailInformasiDriverPage extends StatefulWidget {
  const DetailInformasiDriverPage({Key? key, required this.data}) : super(key: key);
  final Produk data;

  @override
  State<DetailInformasiDriverPage> createState() => _DetailInformasiDriverPageState();
}

class _DetailInformasiDriverPageState extends State<DetailInformasiDriverPage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      setState(() {
        widget.data;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
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
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => EditInformasiDriver(
                        data: widget.data,
                      ))
              );
            },
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                'Edit Profile',
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
        child:  Stack(
          alignment: Alignment.topCenter,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 60, 0, 0),
              child: Expanded(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 28, vertical: 50),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25),
                          topRight: Radius.circular(25)
                      )
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _listData("Nama Driver", widget.data.namaDriver),
                      const SizedBox(height: 20,),
                      _listData("Nomor Telepon", "+62${widget.data.nomorTelfon.toString()}"),
                      const SizedBox(height: 20,),
                      _listData("Kendaraan", widget.data.namaKendaraan),
                      const SizedBox(height: 20,),
                      _listData("Plat Nomor", widget.data.nomorPolisi),
                    ],
                  ),
                ),
              ),
            ),
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage('https://kangsayur.nitipaja.online${widget.data.fotoDriver.toString()}'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _listData(String tittle, String name){
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
          const SizedBox(height: 8,),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xFFF5F5F5),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Text(
                name,
                style: TextStyle(
                  color: ColorValue.neutralColor.withOpacity(0.5),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
