//import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';

abstract class IntfOnJobDone {
  void onJobDone(List<dynamic> result); // Equivalent to JSONArray
  void onJobDoneBitmap(Uint8List result, String blobId); // Bitmap represented as Uint8List
  void onJobDoneInitialized(bool initialized);
}
