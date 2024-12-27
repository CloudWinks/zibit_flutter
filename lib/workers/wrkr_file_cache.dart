import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert'; // For utf8.encode

class FileCache {
  late Directory _cacheDir;

  /// Initialize the cache directory
  Future<void> initCache() async {
    if (await _isExternalStorageAvailable()) {
      _cacheDir = Directory(await _getExternalCacheDir());
    } else {
      _cacheDir = await getTemporaryDirectory();
    }
    if (!_cacheDir.existsSync()) {
      _cacheDir.createSync(recursive: true);
    }
  }

  /// Get the file corresponding to a URL
  File getFile(String url) {
    final fileName = _generateFileName(url);
    return File('${_cacheDir.path}/$fileName');
  }

  /// Clear all files in the cache directory
  void clear() {
    if (_cacheDir.existsSync()) {
      _cacheDir.listSync().forEach((file) {
        if (file is File) {
          file.deleteSync();
        }
      });
    }
  }

  /// Generate a hashed file name for a URL
  String _generateFileName(String url) {
    final bytes = utf8.encode(url); // Convert URL to UTF-8
    final digest = sha256.convert(bytes); // Generate SHA-256 hash
    return digest.toString();
  }

  /// Check if external storage is available
  Future<bool> _isExternalStorageAvailable() async {
    final externalDir = await getExternalStorageDirectory();
    return externalDir != null;
  }

  /// Get external cache directory
  Future<String> _getExternalCacheDir() async {
    final externalDir = await getExternalStorageDirectory();
    return '${externalDir!.path}/TempImages';
  }
}
