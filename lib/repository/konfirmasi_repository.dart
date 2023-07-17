import 'package:kangsayur_seller/model/konfirmasi_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

abstract class KonfirmasiPageRepository {
  Future<KonfirmasiModel> konfirmasi(String transactionCode);
}

class KonfirmasiRepository extends KonfirmasiPageRepository{

  @override
  Future<KonfirmasiModel> konfirmasi(String transactionCode) async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('token');

    final responseGrafik = await http.put(Uri.parse("https://kangsayur.nitipaja.online/api/seller/status/product/update/konfirmasi?transactionCode=$transactionCode"),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },);

    if(responseGrafik.statusCode == 200) {
      KonfirmasiModel konfirmasiModel = konfirmasiModelFromJson(responseGrafik.body);
      return konfirmasiModel;
    } else {
      throw Exception('Gagal mendapatkan data');
    }
  }


}