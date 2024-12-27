import 'dart:convert';
import 'package:http/http.dart' as http;

class RequestHandler {
  final String baseUrl;

  RequestHandler({required this.baseUrl});

  /// Fetch data from the `query` endpoint
  Future<List<String>> queryCWApps(String tableName) async {
    final endpoint = '$baseUrl/query';
    try {
      final response = await http.post(
        Uri.parse(endpoint),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "TableName": tableName,
          "Parameters": {}, // Empty parameters
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List<dynamic> rows = data['Data']['Rows'];
        return rows.map((row) => row.toString()).toList();
      } else {
        throw Exception('Failed to fetch CWApps: HTTP ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching CWApps: $e');
    }
  }

  /// Execute a stored procedure via the `execute` endpoint
  Future<int> executeCWAppsGetProcedure(String procedureName) async {
    final endpoint = '$baseUrl/execute';
    try {
      final response = await http.post(
        Uri.parse(endpoint),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "QueryName": procedureName,
          "Parameters": {}, // Empty parameters
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['Data']; // Assuming it returns the rows affected
      } else {
        throw Exception(
            'Failed to execute procedure: HTTP ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error executing procedure: $e');
    }
  }
}
