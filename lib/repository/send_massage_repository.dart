import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../model/send_massage_model.dart';

abstract class SendMassagePageRepository{
  Future<SendMassageModel> SendMassage(
      String conversationId,
      String message,
      );
}

class SendMassageRepository extends SendMassagePageRepository{
  @override
  Future<SendMassageModel> SendMassage(String conversationId, String message) async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('token');

    var url = Uri.parse('https://kangsayur.nitipaja.online/api/seller/chat/send');
    var response = await http.post(url, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    }, body: {
      'conversationId': conversationId,
      'message': message,
    });

    print(response.body);

    if (response.statusCode == 200) {
      SendMassageModel sendMassageModel = sendMassageModelFromJson(response.body);
      return sendMassageModel;
    } else {
      throw Exception('Gagal mengubah password');
    }
  }

}