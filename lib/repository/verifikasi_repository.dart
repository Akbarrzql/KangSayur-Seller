import 'package:kangsayur_seller/ui/bottom_navigation/tabbar_item/verifikasi.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../model/verifikasi_model.dart';

abstract class VerifikasiPageRepository{
  Future<VerifikasiModel> verifikasi();
}

class VerifikasiRepository extends VerifikasiPageRepository{

  @override
  Future<VerifikasiModel> verifikasi() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('token');

    final responseProduk = await http.get(Uri.parse("https://kangsayur.nitipaja.online/api/seller/produk/display/verify"),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },);

    print(responseProduk.body);
    print(responseProduk.statusCode);

    if(responseProduk.statusCode == 200){
      VerifikasiModel verifikasiModel = verifikasiModelFromJson(responseProduk.body);
      return verifikasiModel;
    }else{
      throw Exception('Gagal mendapatkan data');
    }
  }
}

