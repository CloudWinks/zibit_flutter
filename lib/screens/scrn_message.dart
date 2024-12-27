import 'package:flutter/material.dart';

class ScrnMessage extends StatelessWidget {
  final String errorMessage;
  final String deviceInfo;

  const ScrnMessage({super.key, required this.errorMessage, required this.deviceInfo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Error Message")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "An error occurred:",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(errorMessage, style: const TextStyle(color: Colors.red)),
              const SizedBox(height: 20),
              const Text(
                "Device Information:",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(deviceInfo),
            ],
          ),
        ),
      ),
    );
  }
}
