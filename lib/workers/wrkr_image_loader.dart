import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

class ImageLoader {
  static final ImageLoader _instance = ImageLoader._internal();
  late final String _cacheDirPath;

  factory ImageLoader() {
    return _instance;
  }

  ImageLoader._internal();

  final Map<String, Image> _memoryCache = {};

  /// Initializes the image loader and sets up the cache directory.
  Future<void> init() async {
    final directory = await getTemporaryDirectory();
    _cacheDirPath = '${directory.path}/TempImages';
    final cacheDir = Directory(_cacheDirPath);

    if (!await cacheDir.exists()) {
      await cacheDir.create(recursive: true);
    }
  }

  /// Displays an image in an `ImageView` widget with placeholder support.
  Future<Widget> displayImage({
    required String url,
    required Widget placeholder,
  }) async {
    if (_memoryCache.containsKey(url)) {
      return _memoryCache[url]!;
    }

    try {
      final file = await _getImageFile(url);
      final image = Image.file(file, fit: BoxFit.cover);
      _memoryCache[url] = image;
      return image;
    } catch (e) {
      debugPrint('Error loading image: $e');
      return placeholder;
    }
  }

  /// Downloads the image if not already cached locally and returns the file.
  Future<File> _getImageFile(String url) async {
    final file = File('$_cacheDirPath/${url.hashCode}');

    if (await file.exists()) {
      return file;
    }

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      await file.writeAsBytes(response.bodyBytes);
      return file;
    } else {
      throw Exception('Failed to download image');
    }
  }

  /// Clears both the memory and file cache.
  Future<void> clearCache() async {
    _memoryCache.clear();
    final cacheDir = Directory(_cacheDirPath);
    if (await cacheDir.exists()) {
      final files = cacheDir.listSync();
      for (final file in files) {
        await file.delete();
      }
    }
  }
}
