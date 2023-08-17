import 'package:kangsayur_seller/model/verify_otp_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

abstract class VerifyOtpPageRepository {
  Future<VerifyOtpModel> verifyOtp(String email, String otp);
}

class VerifyOtpPageRepositoryImpl implements VerifyOtpPageRepository {
  @override
  Future<VerifyOtpModel> verifyOtp(String email, String otp) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('token');

    var url = Uri.parse('https://kangsayur.nitipaja.online/api/otp/verify');
    var response = await http.post(url, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    }, body: {
      'email': email,
      'otp': otp,
    });

    print(response.body);

    if (response.statusCode == 200) {
      VerifyOtpModel verifyOtpModel = verifyOtpModelFromJson(response.body);
      return verifyOtpModel;
    } else if (response.statusCode == 419 ) {
      throw Exception('Kode Otp Expired');
    } else if (response.statusCode == 401 ) {
      throw Exception('Kode Otp Salah');
    } else {
      throw Exception('Gagal Verifikasi');
    }
  }
}