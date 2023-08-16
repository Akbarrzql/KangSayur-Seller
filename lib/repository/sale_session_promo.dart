import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../model/sale_session_promo.dart';

abstract class SaleSessionPromoPageRepository{
  Future<SaleSessionPromoModel> GetSessionPromo();
}

class SaleSessionPromoRepository extends SaleSessionPromoPageRepository{
  @override
  Future<SaleSessionPromoModel> GetSessionPromo() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('token');
    var url = Uri.parse('https://kangsayur.nitipaja.online/api/seller/sale/session');
    var response = await http.get(url, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });

    print(response.body);

    if (response.statusCode == 200) {
      SaleSessionPromoModel saleSessionPromoModel = saleSessionPromoModelFromJson(response.body);
      return saleSessionPromoModel;
    } else {
      throw Exception('Gagal mendapatkan data');
    }
  }
}