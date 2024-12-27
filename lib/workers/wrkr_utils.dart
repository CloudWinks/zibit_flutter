import 'dart:convert';
import 'dart:async'; // For Stream
import 'dart:io'; // For OutputStream
import 'package:network_info_plus/network_info_plus.dart';

class Utils {
  /// Convert byte array to hex string
  static String bytesToHex(List<int> bytes) {
    return bytes.map((byte) => byte.toRadixString(16).padLeft(2, '0')).join().toUpperCase();
  }

  /// Get UTF-8 byte array from a string
  static List<int>? getUTF8Bytes(String str) {
    try {
      return utf8.encode(str);
    } catch (e) {
      return null;
    }
    
  }

  /// Load UTF-8 or ANSI text file as a string
  static Future<String> loadFileAsString(String filename) async {
    try {
      final file = File(filename);
      final bytes = await file.readAsBytes();
      if (bytes.length >= 3 && bytes[0] == 0xEF && bytes[1] == 0xBB && bytes[2] == 0xBF) {
        // UTF-8 BOM detected, skip first 3 bytes
        return utf8.decode(bytes.sublist(3));
      }
      return utf8.decode(bytes, allowMalformed: true);
    } catch (e) {
      throw Exception('Error reading file: $e');
    }
  }

  /// Get MAC address of the device
  static Future<String> getMACAddress() async {
    try {
      final info = NetworkInfo();
      return await info.getWifiBSSID() ?? "";
    } catch (e) {
      return "";
    }
  }

  /// Get IP address (IPv4 or IPv6)
  static Future<String> getIPAddress({bool useIPv4 = true}) async {
    try {
      final info = NetworkInfo();
      final ip = await info.getWifiIP();
      if (ip != null) {
        final isIPv4 = ip.contains('.');
        if (useIPv4 && isIPv4) return ip;
        if (!useIPv4 && !isIPv4) return ip;
      }
      return "";
    } catch (e) {
      return "";
    }
  }

  /// Get names of an enum in Dart
  static List<String> getEnumNames<T>(List<T> enumValues) {
    return enumValues.map((e) => e.toString().split('.').last).toList();
  }

  /// Safely parse an integer from a string
  static int getInteger(String? val) {
    if (val == null || val.toLowerCase() == "null" || val.isEmpty) {
      return 0;
    }
    return int.tryParse(val) ?? 0;
  }

  /// Copy data from one stream to another
  static Future<void> copyStream(Stream<List<int>> input, IOSink output) async {
    await for (final data in input) {
      output.add(data); // Write each chunk to the output sink
    }
    await output.flush(); // Ensure all data is written
    await output.close(); // Close the output stream
  }

}
