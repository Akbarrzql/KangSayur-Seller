import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../model/list_chat_seller_model.dart';

abstract class ListChatSellerPageRepository{
  Future<ListChatSellerModel> GetListChat();
}

class ListChatSellerRepository extends ListChatSellerPageRepository{
  @override
  Future<ListChatSellerModel> GetListChat() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('token');

    final responseProduk = await http.get(Uri.parse("https://kangsayur.nitipaja.online/api/seller/chat/list"),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },);

    print(responseProduk.body);
    print(responseProduk.statusCode);

    if(responseProduk.statusCode == 200){
      ListChatSellerModel listChatSellerModel = listChatSellerModelFromJson(responseProduk.body);
      return listChatSellerModel;
    }else{
      throw Exception('Gagal mendapatkan data');
    }
  }

}