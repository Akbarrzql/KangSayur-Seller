//get pemasukan api

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../model/pemasukan_model.dart';

abstract class PemasukanPageRepository {
  Future<PemasukanModel> pemasukan(String custom);
}

class PemasukanRepository extends PemasukanPageRepository{

  @override
  Future<PemasukanModel> pemasukan(String custom) async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('token');

    final responsePemasukan = await http.get(Uri.parse("https://kangsayur.nitipaja.online/api/seller/pemasukan?custom=$custom"),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },);

    print(responsePemasukan.body);
    print(responsePemasukan.statusCode);

    if (responsePemasukan.statusCode == 200) {
      PemasukanModel pemasukan = pemasukanModelFromJson(responsePemasukan.body);
      return pemasukan;
    } else {
      throw Exception('Gagal mendapatkan data');
    }
  }

}

