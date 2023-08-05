import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:kangsayur_seller/model/StatusCreateProdukModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/create_produk_model.dart';

abstract class CreateProdukPageRepository {
  Future<StatusCreateProdukModel> createProduk(
      String namaProduk,
      int kategoriId,
      List<Map<String, dynamic>>? variant,
      );
}

class CreateProdukRepository extends CreateProdukPageRepository {
  @override
  Future<StatusCreateProdukModel> createProduk(
      String namaProduk,
      int kategoriId,
      List<Map<String, dynamic>>? variant,
      ) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('token');
    var url = Uri.parse('https://kangsayur.nitipaja.online/api/seller/produk/create');

    var request = http.MultipartRequest('POST', url);
    request.headers.addAll({
      'Content-Type': 'multipart/form-data',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    });

// Add "nama_produk" and "kategori_id" fields to the request
    request.fields['nama_produk'] = namaProduk;
    request.fields['kategori_id'] = kategoriId.toString();

    // Loop through the variant list and add each variant field separately
    for (int i = 0; i < variant!.length; i++) {
      request.fields['variant[$i][variant]'] = variant[i]['variant'];
      request.fields['variant[$i][variant_desc]'] = variant[i]['variant_desc'];
      request.fields['variant[$i][stok]'] = variant[i]['stok'];
      request.fields['variant[$i][harga_variant]'] = variant[i]['harga_variant'];
    }

    for (int i = 0; i < variant.length; i++) {
      if (variant[i]['images'] != null && variant[i]['images'] is File) {
        var imageFile = variant[i]['images'] as File;
        var imageStream = imageFile.readAsBytes().asStream();
        request.files.add(http.MultipartFile(
          'variant[$i][images]',
          imageStream,
          imageFile.lengthSync(),
          filename: imageFile.path.split('/').last, // Adjust the media type accordingly
        ));
      }
    }

    var response = await request.send();

    String responseData = await response.stream.transform(utf8.decoder).join();
    print(responseData);

    if (response.statusCode == 200) {
      StatusCreateProdukModel statusCreateProdukModel = statusCreateProdukModelFromJson(responseData);
      return statusCreateProdukModel;
    } else {
      throw Exception('Gagal Membuat Produk');
    }

  }
}
