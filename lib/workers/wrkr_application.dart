// //import 'dart:convert';
// import 'dart:io';
// //import 'package:flutter/material.dart';
// import 'package:flutter/foundation.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:network_info_plus/network_info_plus.dart';
// import 'package:zibit_flutter/mock_data/MockUserData.dart';

// class wrkr_application {
//   // Application state variables
//   bool setup = false;
//   String? macAddressWlan0;
//   String? macAddressEth0;
//   String? deviceId;
//   String? deviceSoftwareVersion;
//   String? mobile;
//   String? networkCountryIso;
//   String? networkOperator;
//   String? networkOperatorName;
//   String? simCountryIso;
//   String? simOperator;
//   String? simOperatorName;
//   String? simSerialNumber;
//   String? subscriberId;
//   int? networkType;
//   int? phoneType;
//   String? localeCountry;
//   String? localeLanguage;
//   String? latitude;
//   String? longitude;
//   String? ipv4;
//   String? ipv6;

//   // User-related variables
//   int userId = 0;
//   String? displayName;
//   double sweetMoney = 0;
//   double mobileMoney = 0;
//   double giftMoney = 0;
//   double crisisMoney = 0;
//   Map<String, dynamic>? headOffice;
//   Map<String, dynamic>? rep;
//   Map<String, dynamic>? vendor;
//   Map<String, dynamic>? consumer;
//   String? firstLoginDate;
//   int qtyHeadOffice = 0;
//   int qtyRep = 0;
//   int qtyVendor = 0;
//   int loginCount = 0;

//   Future<void> initialize() async {
//     if (!setup) {
//       // Load default preferences
//       // ignore: unused_local_variable
//       SharedPreferences prefs = await SharedPreferences.getInstance();

//       // Device info
//       final info = NetworkInfo();
//       macAddressWlan0 = await info.getWifiBSSID();
//       macAddressEth0 = await info.getWifiName(); // Adjust as per your need

//       // Locale
//       localeCountry = Platform.localeName.split('_').last;
//       localeLanguage = Platform.localeName.split('_').first;

//       // IP addresses
//       ipv4 = await _getIPAddress(useIPv4: true);
//       ipv6 = await _getIPAddress(useIPv4: false);

//       // Mobile adjustments
//       mobile = await _adjustMobileNumber(mobile);

//       // Perform initial refresh
//       await refresh();

//       setup = true;
//     }
//   }

//   Future<void> refresh() async {
//     List<Map<String, dynamic>> apiResponse = await MockUserData.fetchMockData();

//     if (apiResponse.isNotEmpty) {
//       var user = apiResponse.first;
//       userId = user["id"];
//       displayName = user["displayName"];
//       headOffice = user["headOffice"];
//       rep = user["rep"];
//       vendor = user["vendor"];
//       consumer = user["consumer"];
//       firstLoginDate = user["firstLoginDate"];
//       qtyHeadOffice = user["qtyHeadOffice"];
//       qtyRep = user["qtyRep"];
//       qtyVendor = user["qtyVendor"];
//       loginCount = user["loginCount"];
//       sweetMoney = user["sweetMoney"];
//       mobileMoney = user["mobileMoney"];
//       giftMoney = user["giftMoney"];
//       crisisMoney = user["crisisMoney"];

//       if (kDebugMode) {
//         print("Application refreshed with:");
//         print("User: $displayName, Login Count: $loginCount");
//       }
//     }
//   }

//   // Future<void> refresh() async {
//   //   // Simulate fetching updated user data
//   //   userId = 1; // Example user ID
//   //   displayName = "John Doe";
//   //   headOffice = {"location": "Main HQ", "id": 101};
//   //   rep = {"name": "Sales Rep", "id": 202};
//   //   vendor = {"company": "Vendor Co.", "id": 303};
//   //   consumer = {"name": "Consumer Name", "id": 404};
//   //   firstLoginDate = DateTime.now().toString();
//   //   qtyHeadOffice = 5;
//   //   qtyRep = 10;
//   //   qtyVendor = 15;
//   //   loginCount = 50;
//   //   sweetMoney = 100.5;
//   //   mobileMoney = 200.5;
//   //   giftMoney = 300.5;
//   //   crisisMoney = 400.5;

//   //   // Update application state as needed
//   //   if (kDebugMode) {
//   //     print("Application refreshed");
//   //   }
//   // }

//   Future<String?> _getIPAddress({required bool useIPv4}) async {
//     try {
//       final info = NetworkInfo();
//       final ip = await info.getWifiIP();
//       if (ip != null) {
//         final isIPv4 = ip.contains('.');
//         if (useIPv4 && isIPv4) return ip;
//         if (!useIPv4 && !isIPv4) return ip;
//       }
//       return null;
//     } catch (e) {
//       return null;
//     }
//   }

//   Future<String?> _adjustMobileNumber(String? mobileNumber) async {
//     if (mobileNumber == null) return null;
//     String adjustedMobile = mobileNumber.replaceAll(RegExp(r'[\+\(\)\s]'), '');
//     return adjustedMobile;
//   }
// }
