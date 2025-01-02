import 'package:flutter/material.dart';
import 'package:zibit_flutter/globals/glbl_control_definition.dart';

class ScrnAppDetails extends StatelessWidget {
  final ControlDefinition controlDefinition;

  const ScrnAppDetails({super.key, required this.controlDefinition});

  Widget _buildListTile(String title, String value) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: ListTile(
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        subtitle: Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black54,
          ),
        ),
      ),
    );
  }

  Widget _buildListFromMap(String title, Map<String, dynamic> map) {
    return ExpansionTile(
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      children: map.entries.map((entry) {
        return ListTile(
          title: Text(entry.key),
          subtitle: Text(entry.value.toString()),
        );
      }).toList(),
    );
  }

  Widget _buildListFromIterable(String title, Iterable<dynamic> items) {
    return ExpansionTile(
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      children: items.map((item) {
        if (item is Map<String, dynamic>) {
          return _buildListFromMap('Item', item);
        }
        return ListTile(
          title: Text(item.toString()),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        title: Text(
          controlDefinition.name ?? 'App Details',
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue[700],
      ),
      body: Scrollbar(
        thumbVisibility: true,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: controlDefinition.toJson().entries.map((entry) {
                final key = entry.key.toString(); // Ensure key is String
                final value = entry.value;

                if (value is List) {
                  return _buildListFromIterable(key, value);
                } else if (value is Map<String, dynamic>) {
                  return _buildListFromMap(key, value);
                } else {
                  return _buildListTile(key, value?.toString() ?? 'N/A');
                }
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}
