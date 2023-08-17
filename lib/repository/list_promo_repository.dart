import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../model/list_promo_model.dart';

abstract class ListPromoPageRepository {
  Future<ListPromoModel> listPromo();
}

class ListPromoRespository extends ListPromoPageRepository{
  @override
  Future<ListPromoModel> listPromo() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('token');

    final responseProduk = await http.get(Uri.parse("https://kangsayur.nitipaja.online/api/seller/sale/session"),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },);

    print(responseProduk.body);
    print(responseProduk.statusCode);

    if(responseProduk.statusCode == 200){
      ListPromoModel listPromoModel = listPromoModelFromJson(responseProduk.body);
      return listPromoModel;
    }else{
      throw Exception('Gagal mendapatkan data');
    }

  }

}