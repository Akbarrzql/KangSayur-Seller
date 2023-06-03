import 'package:http/http.dart' as http;

class LoginRepository {
  final String baseUrl;

  LoginRepository({required this.baseUrl});

  Future<String> login({required String email, required String password}) async {
    final url = Uri.parse('$baseUrl/auth/login');

    final response = await http.post(
      url,
      body: {
        'email': email,
        'password': password,
      },
    );

    // Handle the response and extract the token
    if (response.statusCode == 200) {
      // Assuming the response body contains the token as a string
      final token = response.body;
      return token;
    } else {
      throw Exception('Failed to login');
    }
  }
}
