
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../model/register_model.dart';

abstract class RegisterPageRepository{
  Future<RegisterModel> register(
      String email,
      String password,
      String ownerName,
      String phoneNumber,
      String ownerAddress,
      String storeName,
      String description,
      String storeAddress,
      String storeLongitude,
      String storeLatitude,
      String open,
      String close,
      File? photo,
      );
}

class RegisterRepository extends RegisterPageRepository{

  @override
  Future<RegisterModel> register(
      String email,
      String password,
      String ownerName,
      String phoneNumber,
      String ownerAddress,
      String storeName,
      String description,
      String storeAddress,
      String storeLongitude,
      String storeLatitude,
      String open,
      String close,
      File? photo,
      ) async{

    List<int> imageBytes = await File(photo!.path).readAsBytes();
    var multipartFile = http.MultipartFile.fromBytes(
      'photo',
      imageBytes,
      filename: photo!.path.split('/').last,
    );


    var url = Uri.parse('https://kangsayur.nitipaja.online/api/auth/seller/register');
    var request = http.MultipartRequest('POST', url);
    request.headers['Accept'] = 'application/json';
    request.fields['email'] = email;
    request.fields['password'] = password;
    request.fields['owner_name'] = ownerName;
    request.fields['phone_number'] = phoneNumber;
    request.fields['owner_address'] = ownerAddress;
    request.fields['store_name'] = storeName;
    request.fields['description'] = description;
    request.fields['store_address'] = storeAddress;
    request.fields['store_longitude'] = storeLongitude;
    request.fields['store_latitude'] = storeLatitude;
    request.fields['open'] = open;
    request.fields['close'] = close;
    request.files.add(multipartFile);

    var response = await request.send();

    print(response.statusCode);
    var responseBody = await response.stream.bytesToString();
    print(responseBody);

    if(response.statusCode == 200){
      RegisterModel register = registerModelFromJson(responseBody);
      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setString('token', register.accesToken);
      return register;
    }else{
      throw Exception('Gagal Register');
    }
  }

}