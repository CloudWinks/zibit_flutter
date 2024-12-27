import 'package:flutter/material.dart';
import 'package:zibit_flutter/screens/scrn_detail_page.dart';
import 'scrn_grid_item_widget.dart';

class ScrnGridView extends StatefulWidget {
  final String title;
  final List<Map<String, dynamic>> data; // Placeholder for your dataset.

  const ScrnGridView({super.key, required this.title, required this.data});

  @override
  _ScrnGridViewState createState() => _ScrnGridViewState();
}

class _ScrnGridViewState extends State<ScrnGridView> {
  bool initialized = false;

  @override
  void initState() {
    super.initState();
    _initializeGrid();
  }

  Future<void> _initializeGrid() async {
    // Simulate async operation (e.g., fetching data or processing)
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      initialized = true;
    });
  }

  void _onGridItemClick(Map<String, dynamic> item) {
    // Handle grid item click
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailPage(item: item),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: initialized
          ? GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 3 / 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: widget.data.length,
              itemBuilder: (context, index) {
                final item = widget.data[index];
                return GestureDetector(
                  onTap: () => _onGridItemClick(item),
                  child: GridItemWidget(item: item),
                );
              },
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
