import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../model/ulasan_seller_model.dart';

abstract class UlasanSellerPageRepository {
  Future<UlasanSellerModel> getUlasanSeller();
}

class UlasanSellerRepository extends UlasanSellerPageRepository{
  @override
  Future<UlasanSellerModel> getUlasanSeller() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('token');

    final responseProduk = await http.get(Uri.parse("https://kangsayur.nitipaja.online/api/seller/review/belum-dibalas"),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },);

    print(responseProduk.body);
    print(responseProduk.statusCode);

    if(responseProduk.statusCode == 200){
      UlasanSellerModel ulasanModel = ulasanSellerModelFromJson(responseProduk.body);
      return ulasanModel;
    }else{
      throw Exception('Gagal mendapatkan data');
    }
  }
}