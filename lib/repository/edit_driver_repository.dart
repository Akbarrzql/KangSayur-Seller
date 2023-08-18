import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:kangsayur_seller/model/edit_driver_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class EditDriverPageRepository {
  Future<EditDriverModel> editDriver(
      String driverId,
      String nama,
      File? foto,
      String noHp,
      String noPolisi,
      String namaKendaraan,
      );
}

class EditDriverRepository extends EditDriverPageRepository{
  @override
  Future<EditDriverModel> editDriver(String driverId, String nama, File? foto, String noHp, String noPolisi, String namaKendaraan) async{
    List<int> imageBytes2 = foto!.readAsBytesSync();
    var multipartFile2 = http.MultipartFile.fromBytes(
      'photo',
      imageBytes2,
      filename: foto.path.split('/').last,
    );

    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('token');

    var url = Uri.parse('https://kangsayur.nitipaja.online/api/seller/edit/profile');
    var request = http.MultipartRequest('POST', url);
    request.headers['Accept'] = 'application/json';
    request.headers['Authorization'] = 'Bearer $token';
    request.fields['driver_id'] = driverId;
    request.fields['name'] = nama;
    request.files.add(multipartFile2);
    request.fields['phone_number'] = noHp;
    request.fields['nomor_polisi'] = noPolisi;
    request.fields['nama_kendaraan'] = namaKendaraan;

    var response = await request.send();

    print(response.statusCode);
    var responseData = await response.stream.bytesToString();
    print(responseData);

    if(response.statusCode == 200){
      return editDriverModelFromJson(responseData);
    }else{
      throw Exception('Gagal mendapatkan data');
    }
  }

}