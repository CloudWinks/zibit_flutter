import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class ImageLoader {
  // Singleton Cache Manager instance
  static final CacheManager customCacheManager = CacheManager(
    Config(
      'customCacheKey',
      stalePeriod: const Duration(days: 7), // Cache validity
      maxNrOfCacheObjects: 100, // Max number of cached objects
    ),
  );

  /// Loads an image with caching, using CachedNetworkImage for display.
  static Widget loadImage(String url, {BoxFit fit = BoxFit.cover}) {
    return CachedNetworkImage(
      imageUrl: url,
      placeholder: (context, url) => const Center(
        child: CircularProgressIndicator(),
      ),
      errorWidget: (context, url, error) => const Center(
        child: Icon(Icons.error),
      ),
      cacheManager: customCacheManager,
      fit: fit,
    );
  }

  /// Preloads an image to the cache without displaying it.
  static Future<void> preloadImage(String url) async {
    try {
      await customCacheManager.downloadFile(url);
    } catch (e) {
      debugPrint("Error preloading image: $e");
    }
  }

  /// Clears the cache manually.
  static Future<void> clearCache() async {
    await customCacheManager.emptyCache();
  }

  /// Retrieves a file from the cache.
  static Future<File?> getCachedFile(String url) async {
    try {
      return await customCacheManager.getSingleFile(url);
    } catch (e) {
      debugPrint("Error fetching cached file: $e");
      return null;
    }
  }
}
