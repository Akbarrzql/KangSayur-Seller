import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../model/analisa_model.dart';

abstract class AnalisaPageRepository {
  Future<AnalisaModel> analisa(String custom);
}

class AnalisaRepository extends AnalisaPageRepository{

  @override
  Future<AnalisaModel> analisa(String custom) async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('token');
    final responseAnalis = await http.get(Uri.parse("https://kangsayur.nitipaja.online/api/seller/analysis?custom=$custom"),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },);

    print(responseAnalis.body);
    print(responseAnalis.statusCode);

    if (responseAnalis.statusCode == 200) {
      AnalisaModel analisa = analisaModelFromJson(responseAnalis.body);
      return analisa;
    } else {
      throw Exception('Gagal mendapatkan data');
    }
  }
}