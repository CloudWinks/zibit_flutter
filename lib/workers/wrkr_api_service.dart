import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl;

  ApiService({required this.baseUrl});

  Future<void> saveUserData(Map<String, dynamic> userData) async {
    final url = Uri.parse('$baseUrl/UpdateOrCreateUserBySocialID');
    // final url = Uri.parse('$baseUrl/Test');
    try {
      print('Sending user data: ${jsonEncode(userData)}');
      //String jsonbody = jsonEncode(userData); //inspect var for json parsing
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(userData),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        // Parse the response body
        final responseBody = jsonDecode(response.body);

        if (responseBody is List && responseBody.isNotEmpty) {
          final fields = responseBody[0]['fields'];
          final newUserId = fields
              .firstWhere((field) => field['name'] == 'NewUserID')['value'];
          print('User created successfully with ID: $newUserId');
        } else {
          throw Exception('Unexpected API response format: ${response.body}');
        }
      } else {
        throw Exception(
          'Failed to save user. Status Code: ${response.statusCode}, Body: ${response.body}',
        );
      }
    } catch (error) {
      print('Error while saving user: $error');
      throw Exception('Error while saving user: $error');
    }
  }
}
