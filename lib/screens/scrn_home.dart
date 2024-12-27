import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final List<String> cwApps;

  const HomeScreen({super.key, required this.cwApps});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // App Logo
            Image.asset(
              'assets/zibit.png',
              width: 150,
              height: 150,
            ),
            const SizedBox(height: 20),
            const Text(
              'CWApps List',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: cwApps.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: const Icon(Icons.apps),
                    title: Text(cwApps[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
