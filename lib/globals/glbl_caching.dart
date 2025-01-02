import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class CacheService {
  // Save data to cache
  Future<void> saveToCache(String key, dynamic data) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonData = jsonEncode(data); // Convert object to JSON string
      await prefs.setString(key, jsonData);
      print('Data saved to cache with key: $key');
    } catch (e) {
      print('Error saving data to cache: $e');
    }
  }

  // Retrieve data from cache
  Future<dynamic> retrieveFromCache(String key) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonData = prefs.getString(key);
      if (jsonData != null) {
        return jsonDecode(jsonData); // Convert JSON string back to object
      } else {
        print('No data found in cache for key: $key');
        return null;
      }
    } catch (e) {
      print('Error retrieving data from cache: $e');
      return null;
    }
  }

  // Clear specific data from cache
  Future<void> clearCache(String key) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(key);
      print('Cache cleared for key: $key');
    } catch (e) {
      print('Error clearing cache for key: $e');
    }
  }

  // Clear all cache
  Future<void> clearAllCache() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();
      print('All cache cleared');
    } catch (e) {
      print('Error clearing all cache: $e');
    }
  }
}
