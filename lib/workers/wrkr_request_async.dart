import 'dart:convert';
//import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

typedef OnJobDoneCallback = void Function(dynamic result);

class RequestAsync {
  final OnJobDoneCallback listener;
  final Map<String, dynamic>? postData;

  RequestAsync({required this.listener, this.postData});

  Future<void> execute(String url) async {
    try {
      dynamic result;
      if (postData != null) {
        // POST Request
        result = await sendPost(url, postData!);
      } else {
        // GET Request
        result = await sendGet(url);
      }
      listener(result);
    } catch (e) {
      // Handle error and pass back as result
      listener({'error': e.toString()});
    }
  }

  Future<dynamic> sendGet(String url) async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<dynamic> sendPost(String url, Map<String, dynamic> postData) async {
    final response = await http.post(
      Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: json.encode(postData),
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to post data');
    }
  }
}
