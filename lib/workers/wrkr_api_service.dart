import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl;

  ApiService({required this.baseUrl});

  Future<void> saveUserData(Map<String, dynamic> userData) async {
    final url = Uri.parse('$baseUrl/UpdateOrCreateUserBySocialID');
    try {
      print('Sending user data: ${jsonEncode(userData)}');

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
          print('Fields: $fields');

          final userIdField = fields.firstWhere(
            (field) =>
                field['name'] == 'NewUserID' ||
                field['name'] == 'UpdatedUserID',
            orElse: () => {'value': null},
          )['value'];

          if (userIdField != null) {
            print('User processed successfully with ID: $userIdField');
          } else {
            print(
                'Neither NewUserID nor UpdatedUserID was found in the response fields.');
          }
        } else {
          print('Unexpected API response format: ${response.body}');
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
