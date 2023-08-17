import 'package:shared_preferences/shared_preferences.dart';

import '../model/delete_driver_model.dart';
import 'package:http/http.dart' as http;

abstract class DeleteDriverPageRepository {
  Future<DeleteDriverModel> deleteDriver(String driverId);
}

class DeleteDriverRepository extends DeleteDriverPageRepository {

  @override
  Future<DeleteDriverModel> deleteDriver(String driverId) async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('token');
    var url = Uri.parse('https://kangsayur.nitipaja.online/api/seller/driver/delete');
    var response = await http.post(url,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },body: {
      'driverId': driverId,
        });

    print(response.body);
    print(response.statusCode);

    if (response.statusCode == 200) {
      DeleteDriverModel deleteDriverModel = deleteDriverModelFromJson(response.body);
      return deleteDriverModel;
    } else {
      throw Exception('Gagal Login');
    }
  }

}