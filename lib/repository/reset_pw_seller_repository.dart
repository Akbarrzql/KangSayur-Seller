import 'package:kangsayur_seller/model/reset_pw_seller_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

abstract class ResetPwSellerPageRepository {
  Future<ResetPasswordSellerModel> resetPwSeller();
}

class ResetPwSellerRepository extends ResetPwSellerPageRepository {
  @override
  Future<ResetPasswordSellerModel> resetPwSeller() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('token');

    final responseProduk = await http.get(Uri.parse("https://kangsayur.nitipaja.online/api/seller/password/send/mail"),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },);

    print(responseProduk.body);
    print(responseProduk.statusCode);

    if(responseProduk.statusCode == 200){
      ResetPasswordSellerModel resetPasswordSellerModel = resetPasswordSellerModelFromJson(responseProduk.body);
      return resetPasswordSellerModel;
    }else{
      throw Exception('Gagal mendapatkan data');
    }
  }

}