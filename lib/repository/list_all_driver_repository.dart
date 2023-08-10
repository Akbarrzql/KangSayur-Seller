import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../model/list_all_driver_model.dart';

abstract class ListAllDriverPageRepository{
  Future<ListAllDriverModel> listAllDriver();
}

class ListAllDriverRepository extends ListAllDriverPageRepository{
  @override
  Future<ListAllDriverModel> listAllDriver() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('token');

    final responseProduk = await http.get(Uri.parse("https://kangsayur.nitipaja.online/api/seller/driver/list"),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },);

    print(responseProduk.body);
    print(responseProduk.statusCode);

    if(responseProduk.statusCode == 200){
      ListAllDriverModel listAllDriverModel = listAllDriverModelFromJson(responseProduk.body);
      return listAllDriverModel;
    }else{
      throw Exception('Gagal mendapatkan data');
    }
  }

}