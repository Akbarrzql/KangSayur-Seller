import 'package:kangsayur_seller/model/inbox_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

abstract class InboxPageRepository {
  Future<InboxModel> getInbox();
}

class InboxRepository extends InboxPageRepository {
  @override
  Future<InboxModel> getInbox() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('token');

    final responseProduk = await http.get(Uri.parse("https://kangsayur.nitipaja.online/api/seller/inbox/data-inbox"),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },);

    print(responseProduk.body);
    print(responseProduk.statusCode);

    if(responseProduk.statusCode == 200){
      InboxModel inboxModel = inboxModelFromJson(responseProduk.body);
      return inboxModel;
    }else{
      throw Exception('Gagal mendapatkan data');
    }
  }

}