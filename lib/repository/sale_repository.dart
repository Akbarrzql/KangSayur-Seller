import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../model/sale_model.dart';

abstract class SalePageRepository {
  Future<SaleModel> postSale(
      String sessionId,
      String produkId,
      String varianId,
      String hargaSale,
      String stokSale,
  );
}

class SaleRepository extends SalePageRepository {
  @override
  Future<SaleModel> postSale(String sessionId, String produkId, String varianId,
      String hargaSale, String stokSale) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('token');

    var url =
        Uri.parse('https://kangsayur.nitipaja.online/api/seller/sale/create');
    var response = await http.post(url, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    }, body: {
      'session_id': sessionId,
      'produk_id': produkId,
      'variant_id': varianId,
      'harga_sale': hargaSale,
      'stok': stokSale,
    });

    print(response.body);

    if (response.statusCode == 200) {
      SaleModel saleModel = saleModelFromJson(response.body);
      return saleModel;
    } else {
      throw Exception('Gagal mendapatkan data');
    }
  }
}
