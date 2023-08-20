import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../model/room_chat_model.dart';

abstract class RoomChatPageRepository{
  Future<RoomChatModelModel> GetRoomChat(
      String conversationId,
      );
}

class RoomChatRepository extends RoomChatPageRepository{
  @override
  Future<RoomChatModelModel> GetRoomChat(String conversationId) async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('token');

    final responseProduk = await http.get(Uri.parse("https://kangsayur.nitipaja.online/api/seller/chat/room?conversationId=$conversationId"),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },);

    print(responseProduk.body);
    print(responseProduk.statusCode);

    if(responseProduk.statusCode == 200){
      RoomChatModelModel roomChatModelModel = roomChatModelModelFromJson(responseProduk.body);
      return roomChatModelModel;
    }else{
      throw Exception('Gagal mendapatkan data');
    }
  }

}