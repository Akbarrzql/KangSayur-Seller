import 'package:shared_preferences/shared_preferences.dart';
import '../model/produk_model.dart';
import 'package:http/http.dart' as http;

abstract class ProdukPageRepository{
  Future<ProdukModel> produk();
}

class ProdukRepository extends ProdukPageRepository{

  @override
  Future<ProdukModel> produk() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('token');

    final responseProduk = await http.get(Uri.parse("https://kangsayur.nitipaja.online/api/seller/produk/display"),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },);

    print(responseProduk.body);
    print(responseProduk.statusCode);

    if(responseProduk.statusCode == 200){
      ProdukModel produkModel = produkModelFromJson(responseProduk.body);
      return produkModel;
    }else{
      throw Exception('Gagal mendapatkan data');
    }
  }

}

