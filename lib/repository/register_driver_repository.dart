import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../model/register_driver_model.dart';

abstract class RegisterDriverPageRepository{
  Future<ResgisterDriverModel> registerDriver(
      String namaLengkap,
      String email,
      String noHp,
      String noHpDarurat,
      String password,
      // String konfirmasiPassword,
      String jenisKendaraan,
      // String namaKendaraan,
      String platNomor,
      String noRangka,
      File?  photoDriver,
      File?  photoKTP,
      File?  photoSTNK,
      File? photoKendaraan,
      );
}

class RegisterDriverRepository extends RegisterDriverPageRepository{
  @override
  Future<ResgisterDriverModel> registerDriver(String namaLengkap, String email, String noHp, String noHpDarurat, String password, String jenisKendaraan, String platNomor, String noRangka, File? photoDriver, File? photoKTP, File? photoSTNK, File? photoKendaraan) async{

    List<int> imageBytes = photoDriver!.readAsBytesSync();
    var multipartFile = http.MultipartFile.fromBytes(
      'photo',
      imageBytes,
      filename: photoDriver.path.split('/').last,
    );

    List<int> imageBytes2 = photoKTP!.readAsBytesSync();
    var multipartFile2 = http.MultipartFile.fromBytes(
      'photo_ktp',
      imageBytes2,
      filename: photoKTP.path.split('/').last,
    );

    List<int> imageBytes3 = photoSTNK!.readAsBytesSync();
    var multipartFile3 = http.MultipartFile.fromBytes(
      'photo_kk',
      imageBytes3,
      filename: photoSTNK.path.split('/').last,
    );

    List<int> imageBytes4 = photoKendaraan!.readAsBytesSync();
    var multipartFile4 = http.MultipartFile.fromBytes(
      'photo_kendaraan',
      imageBytes4,
      filename: photoKendaraan.path.split('/').last,
    );

    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('token');

    var url = Uri.parse('https://kangsayur.nitipaja.online/api/seller/register/driver');
    var request = http.MultipartRequest('POST', url);
    request.headers['Accept'] = 'application/json';
    request.headers['Authorization'] = 'Bearer $token';
    request.fields['name'] = namaLengkap;
    request.fields['email'] = email;
    request.fields['phone_number'] = noHp;
    request.fields['noTelfon_cadangan'] = noHpDarurat;
    request.fields['password'] = password;
    // request.fields['password_confirmation'] = konfirmasiPassword;
    request.fields['jenis_kendaraan'] = jenisKendaraan;
    // request.fields['nama_kendaraan'] = namaKendaraan;
    request.fields['nomor_polisi'] = platNomor;
    request.fields['nomor_rangka'] = noRangka;
    request.files.add(multipartFile);
    request.files.add(multipartFile2);
    request.files.add(multipartFile3);
    request.files.add(multipartFile4);

    var response = await request.send();

    print(response.statusCode);
    var responseData = await response.stream.bytesToString();
    print(responseData);

    if(response.statusCode == 200){
      ResgisterDriverModel registerDriver = resgisterDriverModelFromJson(responseData);
      return registerDriver;
    }else{
      throw Exception('Gagal mendapatkan data');
    }
  }

}