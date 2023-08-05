import 'package:shared_preferences/shared_preferences.dart';
import '../model/balas_ulasan_model.dart';
import 'package:http/http.dart' as http;

abstract class BalasanUserSellerPageRepository{
  Future<BalasUlasanSellerModel> balas(
      String productId,
      String variantId,
      String transactionCode,
      String reply,
      String idUser
      );
}

class BalasanUserSellerRepository extends BalasanUserSellerPageRepository{
  @override
  Future<BalasUlasanSellerModel> balas(String productId, String variantId, String transactionCode, String reply, String idUser) async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('token');

    final responseGrafik = await http.put(Uri.parse("https://kangsayur.nitipaja.online/api/seller/review/reply?product_id=$productId&variant_id=$variantId&transaction_code=$transactionCode&reply=$reply&id_user=$idUser"),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },);

    if(responseGrafik.statusCode == 200) {
      BalasUlasanSellerModel balasUlasanSellerModel = balasUlasanSellerModelFromJson(responseGrafik.body);
      return balasUlasanSellerModel;
    } else {
      throw Exception('Gagal mendapatkan data');
    }
  }


}