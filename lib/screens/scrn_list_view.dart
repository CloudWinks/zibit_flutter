import 'package:flutter/material.dart';

class ScrnListView extends StatefulWidget {
  final int targetTableId;
  final int targetDataSourceId;
  final String layoutClass;
  final String title;
  final String titleImage;

  const ScrnListView({
    super.key,
    required this.targetTableId,
    required this.targetDataSourceId,
    required this.layoutClass,
    required this.title,
    required this.titleImage,
  });

  @override
  _ScrnListViewState createState() => _ScrnListViewState();
}

class _ScrnListViewState extends State<ScrnListView> {
  late List<Map<String, dynamic>> items; // Mock data source
  bool initialized = false;

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  void _initializeData() {
    // Simulating data fetch
    setState(() {
      items = List.generate(
        20,
        (index) => {
          'id': index,
          'title': 'Item $index',
          'description': 'Description for item $index',
        },
      );
      initialized = true;
    });
  }

  void _onItemClicked(Map<String, dynamic> item) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ItemDetailScreen(item: item),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              // Refresh logic
              _initializeData();
            },
          ),
        ],
      ),
      body: initialized
          ? ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                return ListTile(
                  title: Text(item['title']),
                  subtitle: Text(item['description']),
                  onTap: () => _onItemClicked(item),
                );
              },
            )
          : const Center(child: CircularProgressIndicator()),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add new item logic
          setState(() {
            items.add({
              'id': items.length,
              'title': 'New Item ${items.length}',
              'description': 'Description for new item ${items.length}',
            });
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class ItemDetailScreen extends StatelessWidget {
  final Map<String, dynamic> item;

  const ItemDetailScreen({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(item['title']),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(item['description']),
      ),
    );
  }
}
