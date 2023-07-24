  import 'dart:convert';
  import 'package:http/http.dart' as http;
  import 'package:kangsayur_seller/model/StatusCreateProdukModel.dart';
  import 'package:shared_preferences/shared_preferences.dart';
  import '../model/create_produk_model.dart';

  abstract class CreateProdukPageRepository {
    Future<StatusCreateProdukModel> createProduk(
        String namaProduk,
        int kategoriId,
        List<Map<String, dynamic>> variant,
        );
  }

  class CreateProdukRepository extends CreateProdukPageRepository {
    @override
    Future<StatusCreateProdukModel> createProduk(
        String namaProduk, int kategoriId, List<Map<String, dynamic>> variant) async {
      SharedPreferences pref = await SharedPreferences.getInstance();
      String? token = pref.getString('token');
      var url = Uri.parse('https://kangsayur.nitipaja.online/api/seller/produk/create');

      var request = http.MultipartRequest('POST', url);
      request.headers.addAll({
        'Content-Type': 'multipart/form-data',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      });

      // Tambahkan file gambar ke dalam request
      for (int i = 0; i < variant.length; i++) {
        if (variant[i]['images'] != null && variant[i]['images'] is String) {
          String imagePath = variant[i]['images'];
          var imageFile = await http.MultipartFile.fromPath('variant[$i][images]', imagePath);
          request.files.add(imageFile);
        }
      }

      request.fields.addAll({
        'nama_produk': namaProduk,
        'kategori_id': kategoriId.toString(),
        'variant': jsonEncode(variant)
      });

      var response = await request.send();

      if (response.statusCode == 200) {
        String responseData = await response.stream.transform(utf8.decoder).join();
        StatusCreateProdukModel statusCreateProdukModel = statusCreateProdukModelFromJson(responseData);
        return statusCreateProdukModel;
      } else {
        print(response.statusCode);
        print(response.reasonPhrase);
        throw Exception('Gagal Membuat Produk');
      }
    }
  }
