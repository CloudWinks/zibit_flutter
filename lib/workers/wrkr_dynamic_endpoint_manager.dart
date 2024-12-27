import 'dart:async';
import 'dart:convert'; // For JSON decoding
import 'package:http/http.dart' as http;

class DynamicEndpointManager {
  final Map<String, String> _endpoints = {};

  /// Fetches endpoints from a database or an API.
  Future<void> fetchEndpointsFromDatabase() async {
    try {
      final url = 'http://192.168.68.61:8083/api/Endpoints'; // Correct endpoint
      print('Fetching endpoints from: $url');

      final response = await http.get(Uri.parse(url));

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        // Validate response format
        final data = jsonDecode(response.body);
        if (data is Map<String, dynamic>) {
          data.forEach((key, value) {
            if (value is String) {
              _endpoints[key] = value;
            }
          });
          print('Registered Endpoints: $_endpoints');
        } else {
          throw Exception('Unexpected response format: $data');
        }
      } else {
        throw Exception('Failed to fetch endpoints: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching endpoints: $e');
      throw Exception('Error fetching endpoints');
    }
  }

  /// Retrieves the endpoint associated with the given key.
  /// Returns `null` if the key does not exist.
  String? getEndpoint(String key) {
    print('Fetching endpoint for key: $key');
    return _endpoints[key];
  }

  /// Updates or adds a new endpoint dynamically.
  /// If the key already exists, it updates the URL.
  void updateEndpoint(String key, String newUrl) {
    _endpoints[key] = newUrl;
    print('Updated endpoint: $key -> $newUrl');
  }

  /// Deletes an endpoint by key.
  void deleteEndpoint(String key) {
    _endpoints.remove(key);
    print('Deleted endpoint: $key');
  }

  /// Prints all registered endpoints (for debugging).
  void printAllEndpoints() {
    print('Current endpoints: $_endpoints');
  }
}
