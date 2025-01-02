import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zibit_flutter/globals/glbl_app_model.dart';
import 'package:zibit_flutter/screens/scrn_app_details.dart';
import 'package:zibit_flutter/workers/wrkr_api_service.dart';
import 'package:zibit_flutter/workers/wrkr_auth_service.dart';
import 'package:zibit_flutter/globals/glbl_control_definition.dart';

class ScrnFrame extends StatefulWidget {
  const ScrnFrame({super.key});

  @override
  State<ScrnFrame> createState() => _ScrnFrameState();
}

class _ScrnFrameState extends State<ScrnFrame> {
  final ApiService _apiService = ApiService();
  late LoginService _loginService; // Declare login service
  List<Map<String, dynamic>> cwApps = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loginService = LoginService(context);
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

  Future<void> _logout() async {
    try {
      await _loginService.signOut(); // Call the sign-out method
      Navigator.pushReplacementNamed(
          context, '/login'); // Navigate back to login
      print('User logged out successfully');
    } catch (error) {
      print('Logout failed: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Logout failed: $error')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final appModel = Provider.of<AppModel>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        title: const Text(
          'CloudWinks',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue[700],
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
            onPressed: () {
              _logout(); // Call the logout method
            },
          ),
        ],
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
                      onTap: () async {
                        // Update AppModel with the selected app's details
                        appModel.updateAppData(
                          appid: app['_appid'] ?? 0,
                          appname: app['_appname'] ?? '',
                          targettableid: app['_targettableid'] ?? 0,
                          targetmode: app['_targetmode'] ?? 0,
                          targetdatasourceid: app['_targetdatasourceid'] ?? 0,
                          applogoid: app['_applogoid'] ?? 0,
                          titleimageid: app['_titleimageid'] ?? 0,
                          apptype: app['_apptype'] ?? 0,
                          seq: app['_seq'],
                          baseurl: app['_baseurl'],
                        );

                        // Fetch the control definition using the target table ID
                        final int controlID = appModel.targettableid;
                        try {
                          const String endpoint =
                              '/Query/CWGetControlDefinition';
                          final requestBody = {'ControlID': controlID};

                          // Debugging logs
                          print('Fetching Control Definition...');
                          print('Endpoint: $endpoint');
                          print('Request Body: $requestBody');

                          // Call the API
                          final controlDefinitionResponse =
                              await _apiService.callAPI(endpoint, requestBody);

                          // Debugging log for API response
                          print(
                              'Control Definition Response: $controlDefinitionResponse');

                          // Parse and save the control definition
                          final controlDefinition = ControlDefinition.fromJson(
                              controlDefinitionResponse);

                          // Navigate to app details screen with control definition
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ScrnAppDetails(
                                  controlDefinition: controlDefinition),
                            ),
                          );
                        } catch (error) {
                          print('Error fetching control definition: $error');
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text(
                                    'Failed to fetch control definition.')),
                          );
                        }
                      },
                    ),
                  );
                },
              ),
            ),
    );
  }
}
