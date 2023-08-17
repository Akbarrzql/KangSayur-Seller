import 'package:kangsayur_seller/model/ubah_password_seller_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

abstract class UbahPwSellerPageRepository {
  Future<UbahPasswordSellerModel> ubahPwSeller(String password);
}

class UbahPwSellerRepository extends UbahPwSellerPageRepository {
  @override
  Future<UbahPasswordSellerModel> ubahPwSeller(String password) async {
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
      UbahPasswordSellerModel ubahPasswordSellerModel = ubahPasswordSellerModelFromJson(response.body);
      return ubahPasswordSellerModel;
    } else {
      throw Exception('Gagal mengubah password');
    }
  }
}
