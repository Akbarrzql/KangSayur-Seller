import '../model/validasi_email_model.dart';
import 'package:http/http.dart' as http;

abstract class ValidasiEmailPageRepository {
  Future<ValidasiEmailModel> validasiEmail(String email);
}

class ValidasiEmailRepository extends ValidasiEmailPageRepository{
  @override
  Future<ValidasiEmailModel> validasiEmail(String email) async{
    var url = Uri.parse('https://kangsayur.nitipaja.online/api/twostep/email');
    var response = await http.post(url, headers: {
      'Accept': 'application/json',
    }, body: {
      'email': email,
    });

    print(response.body);

    if (response.statusCode == 200) {
      ValidasiEmailModel validasiEmailModel = validasiEmailModelFromJson(response.body);
      return validasiEmailModel;
    } else {
      throw Exception('Gagal Validasi Email');
    }
  }

}