import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../model/ubah_pw_driver_model.dart';

abstract class UbahPwDriverPageRepository {
  Future<UbahPasswordDriverModel> ubahPwDriver(
      String driverId,
      String password);
}

class UbahPwDriverRepository extends UbahPwDriverPageRepository{
  @override
  Future<UbahPasswordDriverModel> ubahPwDriver(String driverId, String password) async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('token');

    var url = Uri.parse('https://kangsayur.nitipaja.online/api/seller/password/update');
    var response = await http.post(url, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    }, body: {
      'newPassword': password,
    });

    print(response.body);

    if (response.statusCode == 200) {
      UbahPasswordDriverModel ubahPasswordDriverModel = ubahPasswordDriverModelFromJson(response.body);
      return ubahPasswordDriverModel;
    } else {
      throw Exception('Gagal mengubah password');
    }
  }

}