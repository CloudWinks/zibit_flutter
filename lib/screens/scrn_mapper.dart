import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ScrnMapper extends StatelessWidget {
  final String sourceAddress;
  final String destinationAddress;

  const ScrnMapper(
      {super.key,
      required this.sourceAddress,
      required this.destinationAddress});

  // Function to open Google Maps
  void openGoogleMaps(BuildContext context) async {
    final url =
        'https://www.google.com/maps/dir/?api=1&origin=${Uri.encodeComponent(sourceAddress)}&destination=${Uri.encodeComponent(destinationAddress)}&travelmode=driving';

    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Could not open Google Maps."),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mapper"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => openGoogleMaps(context),
          child: Text("Navigate to $destinationAddress"),
        ),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: ScrnMapper(
      sourceAddress: "Danville, KY",
      destinationAddress: "Springfield, KY",
    ),
  ));
}
