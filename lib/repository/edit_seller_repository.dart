import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../model/edit_seller_model.dart';

abstract class EditSellerPageRepository {
  Future<EditSellerModel> editSeller(
      String namaToko,
      String deksripsiToko,
      String alamatToko,
      String openTime,
      String closeTime,
      File? imgHeader,
      File? imgProfile,
      );
}

class EditSellerRepository extends EditSellerPageRepository{
  @override
  Future<EditSellerModel> editSeller(String namaToko, String deksripsiToko, String alamatToko, String openTime, String closeTime, File? imgHeader, File? imgProfile) async{
    List<int> imageBytes = imgHeader!.readAsBytesSync();
    var multipartFile = http.MultipartFile.fromBytes(
      'photo_header',
      imageBytes,
      filename: imgHeader.path.split('/').last,
    );

    List<int> imageBytes2 = imgProfile!.readAsBytesSync();
    var multipartFile2 = http.MultipartFile.fromBytes(
      'photo_profile',
      imageBytes2,
      filename: imgProfile.path.split('/').last,
    );

    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('token');

    var url = Uri.parse('https://kangsayur.nitipaja.online/api/seller/edit/profile');
    var request = http.MultipartRequest('POST', url);
    request.headers['Accept'] = 'application/json';
    request.headers['Authorization'] = 'Bearer $token';
    request.fields['nama_toko'] = namaToko;
    request.fields['deskripsi_toko'] = deksripsiToko;
    request.fields['address'] = alamatToko;
    request.fields['open'] = openTime;
    request.fields['close'] = closeTime;
    request.files.add(multipartFile);
    request.files.add(multipartFile2);

    var response = await request.send();

    print(response.statusCode);
    var responseData = await response.stream.bytesToString();
    print(responseData);

    if(response.statusCode == 200){
      return editSellerModelFromJson(responseData);
    }else{
      throw Exception('Gagal mendapatkan data');
    }
  }

}