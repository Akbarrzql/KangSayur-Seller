import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../model/kategori_model.dart';

abstract class KategoriPageRepository {
  Future<KategoriModel> getKategori();
}

class KategoriRepository extends KategoriPageRepository{

  @override
  Future<KategoriModel> getKategori() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('token');

    final responseProduk = await http.get(Uri.parse("https://kangsayur.nitipaja.online/api/seller/iklan/kategori-toko"),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },);

    print(responseProduk.body);
    print(responseProduk.statusCode);

    if(responseProduk.statusCode == 200){
      KategoriModel kategoriModel = kategoriModelFromJson(responseProduk.body);
      return kategoriModel;
    }else{
      throw Exception('Gagal mendapatkan data');
    }
  }

}