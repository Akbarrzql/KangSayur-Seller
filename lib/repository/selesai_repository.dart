import 'package:kangsayur_seller/model/disiapkan_model.dart';
import 'package:kangsayur_seller/model/pesanan_model.dart';
import 'package:kangsayur_seller/model/selesai_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


abstract class SelesaiPageRepository{
  Future<SelesaiModel> selesai();
}

class SelesaiRepository extends SelesaiPageRepository{
  @override
  Future<SelesaiModel> selesai() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('token');

    final responseProduk = await http.get(Uri.parse("https://kangsayur.nitipaja.online/api/seller/status/product/selesai"),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },);

    print(responseProduk.body);
    print(responseProduk.statusCode);

    if(responseProduk.statusCode == 200){
      SelesaiModel produkModel = selesaiModelFromJson(responseProduk.body);
      return produkModel;
    }else{
      throw Exception('Gagal mendapatkan data');
    }
  }
}
