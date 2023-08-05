import 'package:kangsayur_seller/model/all_ulasan_user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

abstract class AllUlasanPageRepository {
  Future<AllUlasanSellerModel> getAllUlasan();
}

class AllUlasanRepository extends AllUlasanPageRepository{
  @override
  Future<AllUlasanSellerModel> getAllUlasan() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('token');

    final responseProduk = await http.get(Uri.parse("https://kangsayur.nitipaja.online/api/seller/review/all"),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },);

    print(responseProduk.body);
    print(responseProduk.statusCode);

    if(responseProduk.statusCode == 200){
      AllUlasanSellerModel ulasanModel = allUlasanSellerModelFromJson(responseProduk.body);
      return ulasanModel;
    }else{
      throw Exception('Gagal mendapatkan data');
    }
  }

}

