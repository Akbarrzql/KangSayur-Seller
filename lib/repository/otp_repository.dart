import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../model/otp_model.dart';

abstract class OtpPageRepository{
  Future<OtpModel> getOtp(String email);
}

class OtpRepository extends OtpPageRepository{
  @override
  Future<OtpModel> getOtp(String email) async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('token');

    var url =
    Uri.parse('https://kangsayur.nitipaja.online/api/otp/generate');
    var response = await http.post(url, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    }, body: {
      'email': email,
    });

    print(response.body);

    if (response.statusCode == 200) {
      OtpModel otpModel = otpModelFromJson(response.body);
      return otpModel;
    } else {
      throw Exception('Gagal mendapatkan data');
    }
  }

}