import 'package:flutter/material.dart';
import 'package:zibit_flutter/workers/wrkr_api_service.dart';
import 'package:zibit_flutter/screens/scrn_app_details.dart';

class ScrnFrame extends StatefulWidget {
  const ScrnFrame({super.key});

  @override
  State<ScrnFrame> createState() => _ScrnFrameState();
}

class _ScrnFrameState extends State<ScrnFrame> {
  final ApiService _apiService = ApiService();
  List<Map<String, dynamic>> cwApps = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchCWApps();
  }

  Future<void> fetchCWApps() async {
    try {
      const String endpoint = '/Query/spCWApps';
      const Map<String, dynamic> requestBody = {"queryName": "CWAppsGetAll"};
      final response = await _apiService.callAPI(endpoint, requestBody);

      if (response != null &&
          response['status'] == 'Success' &&
          response['data'] is List) {
        List<Map<String, dynamic>> apps = [];
        for (var item in response['data']) {
          final fields = item['fields'] as List<dynamic>;
          final appData = {
            for (var field in fields)
              field['name'] as String: field['value'] // Explicitly cast
          };
          apps.add(appData);
        }
        setState(() {
          cwApps = apps;
          isLoading = false;
        });
      } else {
        throw Exception('Unexpected response format');
      }
    } catch (error) {
      print('Error fetching CWApps: $error');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        title: const Text(
          'CloudWinks',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue[700],
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView.builder(
                itemCount: cwApps.length,
                itemBuilder: (context, index) {
                  final app = cwApps[index];
                  return Card(
                    color: Colors.white,
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    elevation: 4.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.blue[100],
                        child: const Icon(
                          Icons.apps,
                          color: Colors.blue,
                        ),
                      ),
                      title: Text(
                        app['_appname'] ?? 'Unknown App',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      subtitle: Text(
                        'App ID: ${app['_appid'] ?? 'N/A'}',
                        style: const TextStyle(color: Colors.black54),
                      ),
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.blue,
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ScrnAppDetails(
                              appDetails: Map<String, dynamic>.from(app),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
    );
  }
}
