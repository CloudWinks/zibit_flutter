import 'package:flutter/material.dart';

class GridItemWidget extends StatelessWidget {
  final Map<String, dynamic> item;

  const GridItemWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (item['image'] != null)
            Image.network(item['image'], height: 60, width: 60, fit: BoxFit.cover),
          const SizedBox(height: 8),
          Text(
            item['title'] ?? 'Unknown',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
