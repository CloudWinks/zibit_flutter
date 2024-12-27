import 'package:flutter/material.dart';

class ScrnTabFrame extends StatefulWidget {
  final int targetTableId;
  final int targetDatasourceId;
  final List<String> keyNames;
  final List<String> keyValues;
  final String title;
  final String titleImage;

  const ScrnTabFrame({
    super.key,
    required this.targetTableId,
    required this.targetDatasourceId,
    this.keyNames = const [],
    this.keyValues = const [],
    this.title = "Zibit",
    this.titleImage = "",
  });

  @override
  _ScrnTabFrameState createState() => _ScrnTabFrameState();
}

class _ScrnTabFrameState extends State<ScrnTabFrame>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<TabData> _tabs = [];
  bool initialized = false;

  @override
  void initState() {
    super.initState();
    _fetchTabData();
  }

  void _fetchTabData() {
    // Simulate fetching data from a database or server
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _tabs.addAll([
          TabData(label: 'Tab 1', content: 'Content for Tab 1'),
          TabData(label: 'Tab 2', content: 'Content for Tab 2'),
          TabData(label: 'Tab 3', content: 'Content for Tab 3'),
        ]);
        _tabController = TabController(length: _tabs.length, vsync: this);
        initialized = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!initialized) {
      return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        bottom: TabBar(
          controller: _tabController,
          tabs: _tabs.map((tab) => Tab(text: tab.label)).toList(),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: _tabs.map((tab) {
          return Center(
            child: Text(tab.content),
          );
        }).toList(),
      ),
    );
  }
}

class TabData {
  final String label;
  final String content;

  TabData({required this.label, required this.content});
}
