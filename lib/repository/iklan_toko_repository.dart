import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:kangsayur_seller/model/iklan_toko_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class IklanTokoPageRepository{
  Future postIklanToko(File imgPamflet);
}

class IklanTokoRepository implements IklanTokoPageRepository{
  @override
  Future postIklanToko(File imgPamflet) async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('token');

    var request = http.MultipartRequest(
      'POST',
      Uri.parse("https://kangsayur.nitipaja.online/api/seller/iklan/toko/add"),
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

    var response = await request.send();

    print(response.statusCode);
    print(response.reasonPhrase);
    print(await response.stream.bytesToString());

    if (response.statusCode == 200) {
      var responseString = await response.stream.bytesToString();
      IklanTokoModel iklanTokoModel = iklanTokoModelFromJson(responseString);
      return iklanTokoModel;
    } else {
      throw Exception('Gagal mendapatkan data');
    }
  }
}