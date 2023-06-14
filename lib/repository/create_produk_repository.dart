import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kangsayur_seller/model/StatusCreateProdukModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/create_produk_model.dart';

abstract class CreateProdukPageRepository{
  Future<StatusCreateProdukModel> createProduk(
      String namaProduk,
      int kategoriId,
      List<Map<String, dynamic>> variant,
      );
}

class CreateProdukRepository extends CreateProdukPageRepository{

  @override
  Future<StatusCreateProdukModel> createProduk(String namaProduk, int kategoriId, List<Map<String, dynamic>> variant) async{

    Map<String, dynamic> data = {
      'nama_produk': namaProduk,
      'kategori_id': kategoriId,
      'variant': variant
    };

    String jsonData = jsonEncode(data);
    String formattedJsonData = jsonData.replaceAll('/', '');

    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('token');
    var url = Uri.parse('https://kangsayur.nitipaja.online/api/seller/produk/create');
    var response = await http.post(url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        }
        ,body: formattedJsonData);

    print(response.body);
    print(response.statusCode);

    if (response.statusCode == 200) {
      StatusCreateProdukModel statusCreateProdukModel = statusCreateProdukModelFromJson(response.body);
      return statusCreateProdukModel;
    } else {
      throw Exception('Gagal Membuat Produk');
    }
  }

}