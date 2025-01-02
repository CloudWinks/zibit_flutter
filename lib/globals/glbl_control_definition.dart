import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:zibit_flutter/data/CWButton.dart';
import 'package:zibit_flutter/data/CWField.dart';
import 'package:zibit_flutter/data/CWParameter.dart';
import 'package:zibit_flutter/globals/glbl_caching.dart';
import 'package:zibit_flutter/workers/wrkr_api_service.dart';

class ControlDefinition extends ChangeNotifier {
  final int controlId;
  final int controltype;
  final int mode;
  final String? name; // Optional field
  final String? layout; // Optional field
  final int formatid;
  final int menutype;
  final int gridcolumns;
  final bool? titlebar; // Optional field
  final String? title; // Optional field
  final String? titlefield; // Optional field
  final String? titleimagefield; // Optional field
  final bool? pickcontact; // Optional field
  final bool? getgeo; // Optional field
  final int? targetcontrolid; // Optional field
  final int? targetcontrolmode; // Optional field
  final List<Field>? fields; // Optional field
  final List<Button>? buttons; // Optional field
  final List<Parameter>? params; // Newly added optional field

  ControlDefinition({
    required this.controlId,
    required this.controltype,
    required this.mode,
    this.name,
    this.layout,
    required this.formatid,
    required this.menutype,
    required this.gridcolumns,
    this.titlebar,
    this.title,
    this.titlefield,
    this.titleimagefield,
    this.pickcontact,
    this.getgeo,
    this.targetcontrolid,
    this.targetcontrolmode,
    this.fields,
    this.buttons,
    this.params, // Include params in the constructor
  });

  // Factory constructor to create from JSON
  factory ControlDefinition.fromJson(Map<String, dynamic> json) {
    return ControlDefinition(
      controlId: json['controlId'] ?? 0, // Default to 0 if null
      controltype: json['controltype'] ?? 0,
      mode: json['mode'] ?? 0,
      name: json['name'] ?? '', // Default to empty string if null
      layout: json['layout'] ?? '', // Default to empty string if null
      formatid: json['formatid'] ?? 0,
      menutype: json['menutype'] ?? 0,
      gridcolumns: json['gridcolumns'] ?? 0,
      titlebar: json['titlebar'] ?? false, // Default to false if null
      title: json['title'] ?? '', // Default to empty string if null
      titlefield: json['titlefield'] ?? '', // Default to empty string if null
      titleimagefield:
          json['titleimagefield'] ?? '', // Default to empty string if null
      pickcontact: json['pickcontact'] ?? false, // Default to false if null
      getgeo: json['getgeo'] ?? false, // Default to false if null
      targetcontrolid: json['targetcontrolid'], // Allow null
      targetcontrolmode: json['targetcontrolmode'], // Allow null
      fields: json['fields'] != null
          ? List<Field>.from(json['fields'].map((x) => Field.fromJson(x)))
          : [], // Default to empty list if null
      buttons: json['buttons'] != null
          ? List<Button>.from(json['buttons'].map((x) => Button.fromJson(x)))
          : [], // Default to empty list if null
      params: json['params'] != null
          ? List<Parameter>.from(
              json['params'].map((x) => Parameter.fromJson(x)))
          : [], // Default to empty list if null
    );
  }

  // Method to convert to JSON (useful for debugging or sending data back to the server)
  Map<String, dynamic> toJson() {
    return {
      'controlId': controlId,
      'controltype': controltype,
      'mode': mode,
      'name': name,
      'layout': layout,
      'formatid': formatid,
      'menutype': menutype,
      'gridcolumns': gridcolumns,
      'titlebar': titlebar,
      'title': title,
      'titlefield': titlefield,
      'titleimagefield': titleimagefield,
      'pickcontact': pickcontact,
      'getgeo': getgeo,
      'targetcontrolid': targetcontrolid,
      'targetcontrolmode': targetcontrolmode,
      'fields': fields?.map((x) => x.toJson()).toList(),
      'buttons': buttons?.map((x) => x.toJson()).toList(),
      'params': params?.map((x) => x.toJson()).toList(),
    };
  }

  // Fetch from API or cache
  static Future<ControlDefinition> fetchAndCache(
      int controlId, ApiService apiService) async {
    final cacheService = CacheService();

    // Check cache first
    final cachedData =
        await cacheService.retrieveFromCache('control_$controlId');
    if (cachedData != null) {
      print('Using cached data for Control ID: $controlId');
      return ControlDefinition.fromJson(jsonDecode(cachedData));
    }

    // Fetch from API if not in cache
    try {
      const String endpoint = '/Query/CWGetControlDefinition';
      final response =
          await apiService.callAPI(endpoint, {'ControlID': controlId});
      final controlDefinition = ControlDefinition.fromJson(response);

      // Save to cache
      await cacheService.saveToCache(
          'control_$controlId', jsonEncode(controlDefinition.toJson()));

      print('Fetched and cached control definition for Control ID: $controlId');
      return controlDefinition;
    } catch (error) {
      print('Error fetching control definition: $error');
      throw Exception('Failed to fetch control definition.');
    }
  }
}
