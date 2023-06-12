import 'package:kangsayur_seller/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

abstract class ProfilePageRepository {
  Future<UserModel> profile();
}

class ProfileRepository extends ProfilePageRepository{

  @override
  Future<UserModel> profile() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('token');

    final responseUser = await http.get(Uri.parse("https://kangsayur.nitipaja.online/api/seller/profile"),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },);

    print(responseUser.body);
    print(responseUser.statusCode);

    if (responseUser.statusCode == 200) {
      UserModel user = userModelFromJson(responseUser.body);
      return user;
    } else {
      throw Exception('Gagal mendapatkan data');
    }
  }
}