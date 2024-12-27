// import 'dart:convert';
// import 'package:http/http.dart' as http;

// class AppDataSingleton {
//   // Private constructor
//   AppDataSingleton._privateConstructor();

//   // Single instance
//   static final AppDataSingleton instance =
//       AppDataSingleton._privateConstructor();

//   // List to store fetched apps
//   List<String> cwApps = [];

//   /// Fetch data from the specified URL and store it in the singleton
//   Future<void> fetchAndStoreCWApps() async {
//     const String apiUrl = 'http://192.168.68.61:8083/api/CWApps';

//     try {
//       final response = await http.get(Uri.parse(apiUrl));

//       if (response.statusCode == 200) {
//         // Parse the JSON response into a list of strings
//         final List<dynamic> data = jsonDecode(response.body);
//         cwApps = data.map((e) => e.toString()).toList();
//       } else {
//         throw Exception('Failed to fetch CWApps: HTTP ${response.statusCode}');
//       }
//     } catch (e) {
//       throw Exception('Error fetching CWApps: $e');
//     }
//   }

//   /// Retrieve the stored apps list
//   List<String> getStoredApps() {
//     return cwApps;
//   }
// }
