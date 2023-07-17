import 'package:kangsayur_seller/model/disiapkan_model.dart';
import 'package:kangsayur_seller/model/pesanan_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


abstract class DisiapkanPageRepository{
  Future<DisiapkanModel> disiapkan();
}

class DisiapkanRepository extends DisiapkanPageRepository{
  @override
  Future<DisiapkanModel> disiapkan() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('token');

    final responseProduk = await http.get(Uri.parse("https://kangsayur.nitipaja.online/api/seller/status/product/disiapkan"),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },);

    print(responseProduk.body);
    print(responseProduk.statusCode);

    if(responseProduk.statusCode == 200){
      DisiapkanModel produkModel = disiapkanModelFromJson(responseProduk.body);
      return produkModel;
    }else{
      throw Exception('Gagal mendapatkan data');
    }
  }
}
