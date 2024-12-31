import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  // Base URL
  static const String _baseUrl = 'http://192.168.68.61:8083/api';

  // Generic method for making POST requests
  Future<dynamic> callAPI(String endpoint, Map<String, dynamic> data) async {
    final String url = '$_baseUrl$endpoint';
    try {
      print('Sending data to: $url');
      print('Request body: ${jsonEncode(data)}');

      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        print('Data processed successfully: $responseBody');
        return responseBody;
      } else {
        throw Exception(
          'Failed to save data. Status Code: ${response.statusCode}, Body: ${response.body}',
        );
      }
    } catch (error) {
      print('Error while saving data: $error');
      throw Exception('Error while saving data: $error');
    }
  }

  // Generic GET method
  Future<dynamic> getData(String endpoint) async {
    final String url = '$_baseUrl$endpoint'; // Use _baseUrl here

    try {
      print('Sending GET request to: $url');

      final response = await http.get(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        // Return parsed response body
        return jsonDecode(response.body);
      } else {
        throw Exception(
          'Failed to fetch data. Status Code: ${response.statusCode}, Body: ${response.body}',
        );
      }
    } catch (error) {
      print('Error while fetching data: $error');
      throw Exception('Error while fetching data: $error');
    }
  }
}
