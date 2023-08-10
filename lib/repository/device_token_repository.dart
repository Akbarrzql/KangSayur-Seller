import '../model/device_token_model.dart';
import 'package:http/http.dart' as http;

abstract class DeviceTokenPageRepository {
  Future<UpdateDeviceTokenModel> sendDeviceToken(String email, String password, String deviceToken);
}

class DeviceTokenRepository extends DeviceTokenPageRepository {
  @override
  Future<UpdateDeviceTokenModel> sendDeviceToken(String email, String password, String deviceToken) async {
    var url = Uri.parse('https://kangsayur.nitipaja.online/api/auth/update/device/token?email=$email&password=$password&device_token=$deviceToken');
    var response = await http.get(url,
        headers: {
          'Accept': 'application/json',
        },);

    print(response.body);
    print(response.statusCode);

    if (response.statusCode == 200) {
      UpdateDeviceTokenModel updateDeviceTokenModel = updateDeviceTokenModelFromJson(response.body);
      return updateDeviceTokenModel;
    } else {
      throw Exception('Gagal Login');
    }
  }
}