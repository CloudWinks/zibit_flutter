import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DbsTable {
  int? userId;
  String? name;
  String? layout;
  String? format;
  int mode = 0;
  int targetMode = 0;

  Map<String, dynamic> params = {};
  List<Field> fields = [];
  List<Button> buttons = [];
  List<Action> postSaveActions = [];
  List<String> keys = [];
  List<String> headers = [];
  bool initialized = false;

  // Constructor
  DbsTable({this.userId, this.name});

  // Set user ID
  void setUserId(int id) {
    userId = id;
  }

  // Add parameter
  void addParameter(String key, dynamic value) {
    params[key] = value;
  }

  // Add field
  void addField(Field field) {
    fields.add(field);
    headers.add(field.header);
  }

  // Execute query
  Future<void> executeQuery(String url) async {
    if (userId != null) {
      params['_userid'] = userId;
    }

    try {
      final body = jsonEncode({
        'table': name,
        'parameters': params,
      });

      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: body,
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        onJobDone(data);
      } else {
        throw Exception('Failed to execute query: ${response.body}');
      }
    } catch (e) {
      debugPrint('Error executing query: $e');
    }
  }

  // Post save actions
  void doPostSave() {
    for (var action in postSaveActions) {
      action.execute();
    }
  }

  // On Job Done Callback
  void onJobDone(dynamic result) {
    if (result is List) {
      debugPrint('Query executed successfully: $result');
      initialized = true;
    } else {
      debugPrint('Unexpected result format: $result');
    }
  }
}

// Helper classes
class Field {
  final String name;
  final String header;
  final int dbType;
  final int inputType;
  final bool visible;
  final bool enabled;
  final int alignment;

  Field({
    required this.name,
    required this.header,
    required this.dbType,
    required this.inputType,
    this.visible = true,
    this.enabled = true,
    this.alignment = 0,
  });
}

class Button {
  final String name;
  final int id;
  final int actionId;

  Button({required this.name, required this.id, required this.actionId});
}

class Action {
  final String className;
  final String constants;
  final List<String> dataFields;

  Action({required this.className, required this.constants, required this.dataFields});

  void execute() {
    debugPrint('Executing action: $className');
  }
}
