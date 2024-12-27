import 'dart:convert';
import 'package:http/http.dart' as http;

class JSONParser {
  // Fetch JSON from a given URL
  Future<Map<String, dynamic>?> getJSONFromUrl(String url) async {
    try {
      // Make HTTP POST request
      final response = await http.post(Uri.parse(url));
      
      // Check for successful response
      if (response.statusCode == 200) {
        // Decode JSON response into a Map
        return json.decode(response.body) as Map<String, dynamic>;
      } else {
        print('HTTP Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching JSON: $e');
    }
    return null;
  }
}