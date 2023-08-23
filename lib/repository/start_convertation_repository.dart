import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../model/start_convertation_model.dart';

abstract class StartConveratationPageRepository{
  Future<StartConvertationModel> postStartConvertation(String userId);
}

class StartConvertationRepository extends StartConveratationPageRepository{
  @override
  Future<StartConvertationModel> postStartConvertation(String userId) async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('token');

    final responseProduk = await http.post(Uri.parse("https://kangsayur.nitipaja.online/api/seller/chat/start"),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },body: {
        'interlocutor': userId,
      });

    print(responseProduk.body);
    print(responseProduk.statusCode);

    if(responseProduk.statusCode == 200){
      StartConvertationModel startConvertationModel = startConvertationModelFromJson(responseProduk.body);
      return startConvertationModel;
    }else{
      throw Exception('Gagal mendapatkan data');
    }
  }

}