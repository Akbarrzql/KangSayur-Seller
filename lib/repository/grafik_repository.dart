import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../model/grafik_model.dart';

abstract class GrafikPageRepository {
  Future<GrafikModel> grafik(String custom);
}

class GrafikRepository extends GrafikPageRepository{

  @override
  Future<GrafikModel> grafik(String custom) async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('token');

    final responseGrafik = await http.get(Uri.parse("https://kangsayur.nitipaja.online/api/seller/grafik/penjualan?custom=$custom"),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },);

    if(responseGrafik.statusCode == 200) {
      GrafikModel grafik = grafikModelFromJson(responseGrafik.body);
      return grafik;
    } else {
      throw Exception('Gagal mendapatkan data');
    }
  }
}