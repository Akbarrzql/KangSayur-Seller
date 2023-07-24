import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../model/iklan_model.dart';

abstract class IklanPageRepository {
  Future<IklanModel> postIklan(
      File imgPamflet,
      int kategoriId,
      );
}

class IklanRepository extends IklanPageRepository{

  @override
  Future<IklanModel> postIklan(File imgPamflet, int kategoriId) async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('token');

    var request = http.MultipartRequest(
      'POST',
      Uri.parse("https://kangsayur.nitipaja.online/api/seller/iklan/add"),
    );

    request.headers.addAll({
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });

    request.files.add(http.MultipartFile(
      'img_pamflet',
      imgPamflet.readAsBytes().asStream(),
      imgPamflet.lengthSync(),
      filename: imgPamflet.path.split('/').last,
    ));
    request.fields['kategori_id'] = kategoriId.toString();


    var response = await request.send();

    print(response.statusCode);
    print(response.reasonPhrase);

    if (response.statusCode == 200) {
      var responseString = await response.stream.bytesToString();
      IklanModel iklanModel = iklanModelFromJson(responseString);
      return iklanModel;
    } else {
      throw Exception('Gagal mendapatkan data');
    }

  }



}