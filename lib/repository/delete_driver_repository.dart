import '../model/delete_driver_model.dart';
import 'package:http/http.dart' as http;

abstract class DeleteDriverPageRepository {
  Future<DeleteDriverModel> deleteDriver(String driverId);
}

class DeleteDriverRepository extends DeleteDriverPageRepository {

  @override
  Future<DeleteDriverModel> deleteDriver(String driverId) async{
    var url = Uri.parse('https://kangsayur.nitipaja.online/api/auth/login');
    var response = await http.post(url,
        headers: {
          'Accept': 'application/json',
        },body: {
      'driverId': driverId,
        });

    print(response.body);
    print(response.statusCode);

    if (response.statusCode == 200) {
      DeleteDriverModel deleteDriverModel = deleteDriverModelFromJson(response.body);
      return deleteDriverModel;
    } else {
      throw Exception('Gagal Login');
    }
  }

}