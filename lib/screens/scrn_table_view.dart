import 'package:flutter/material.dart';

class ScrnTableView extends StatefulWidget {
  final int targetTableId;
  final int targetDatasourceId;
  final String layoutClass;
  final List<String>? keyNames;
  final List<String>? keyValues;
  final String title;

  const ScrnTableView({
    super.key,
    required this.targetTableId,
    required this.targetDatasourceId,
    this.layoutClass = "",
    this.keyNames,
    this.keyValues,
    this.title = "Zibit",
  });

  @override
  _ScrnTableViewState createState() => _ScrnTableViewState();
}

class _ScrnTableViewState extends State<ScrnTableView> {
  bool initialized = false;
  List<Map<String, dynamic>> tableData = [];
  List<String> tableHeaders = [];

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  void _fetchData() async {
    // Simulating data fetch with a delay
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      tableHeaders = ["Header 1", "Header 2", "Header 3"]; // Example headers
      tableData = [
        {"Header 1": "Row 1 Col 1", "Header 2": "Row 1 Col 2", "Header 3": "Row 1 Col 3"},
        {"Header 1": "Row 2 Col 1", "Header 2": "Row 2 Col 2", "Header 3": "Row 2 Col 3"},
      ];
      initialized = true;
    });
  }

  void _onRowTap(Map<String, dynamic> rowData) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(
            title: const Text("Row Details"),
          ),
          body: Center(
            child: Text("Tapped row: ${rowData.toString()}"),
          ),
        ),
      ),
    );
  }

  void _onMenuSelected(String value) {
    // Handle menu item actions
    print("Menu item selected: $value");
  }

  @override
  Widget build(BuildContext context) {
    if (!initialized) {
      return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          PopupMenuButton<String>(
            onSelected: _onMenuSelected,
            itemBuilder: (context) => [
              const PopupMenuItem(value: "Zibit Inc", child: Text("Zibit Inc")),
              const PopupMenuItem(value: "Manager", child: Text("Manager")),
              const PopupMenuItem(value: "Rep", child: Text("Rep")),
              const PopupMenuItem(value: "Vendor", child: Text("Vendor")),
              const PopupMenuItem(value: "Settings", child: Text("Settings")),
              const PopupMenuItem(value: "Refresh", child: Text("Refresh")),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          // Button Menu
          if (widget.layoutClass == "loVertical2")
            Container(
              color: Colors.green[200],
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(onPressed: () {}, child: const Text("Save")),
                  ElevatedButton(onPressed: () {}, child: const Text("Edit")),
                ],
              ),
            ),

          // Table Layout
          Expanded(
            child: ListView(
              children: [
                Table(
                  border: TableBorder.all(),
                  children: [
                    TableRow(
                      children: tableHeaders
                          .map((header) => Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  header,
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ))
                          .toList(),
                    ),
                    ...tableData.map((rowData) {
                      return TableRow(
                        children: rowData.values
                            .map((value) => GestureDetector(
                                  onTap: () => _onRowTap(rowData),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(value.toString()),
                                  ),
                                ))
                            .toList(),
                      );
                    }),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
