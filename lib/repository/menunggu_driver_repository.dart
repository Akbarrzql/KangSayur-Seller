import 'package:kangsayur_seller/model/menunggu_driver_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

abstract class MenungguDriverPageRepository{
  Future<MenungguDriverModel> menunggu();
}

class MenungguDriverRepository extends MenungguDriverPageRepository{

  @override
  Future<MenungguDriverModel> menunggu() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('token');

    final responseProduk = await http.get(Uri.parse("https://kangsayur.nitipaja.online/api/seller/status/product/menunggu-driver"),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },);

    print(responseProduk.body);
    print(responseProduk.statusCode);

    if(responseProduk.statusCode == 200){
      MenungguDriverModel produkModel = menungguDriverModelFromJson(responseProduk.body);
      return produkModel;
    }else{
      throw Exception('Gagal mendapatkan data');
    }
  }
}