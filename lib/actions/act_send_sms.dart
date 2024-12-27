// import 'package:telephony/telephony.dart';
// import 'package:flutter/material.dart';

// class ActSendTextSMS {
//   final Telephony telephony = Telephony.instance;

//   Future<void> sendSMS(String number, String message) async {
//     try {
//       // Permissions
//       bool? permissionsGranted = await telephony.requestSmsPermissions;

//       if (permissionsGranted == true) {
//         // Send SMS
//         telephony.sendSms(
//           to: number,
//           message: message,
//           statusListener: _onSmsStatusChanged,
//         );
//       } else {
//         throw Exception("SMS permissions not granted");
//       }
//     } catch (e) {
//       debugPrint("Error sending SMS: $e");
//     }
//   }

//   void _onSmsStatusChanged(SendStatus status) {
//     switch (status) {
//       case SendStatus.SENT:
//         debugPrint("SMS Sent");
//         break;
//       case SendStatus.DELIVERED:
//         debugPrint("SMS Delivered");
//         break;
//       default:
//         debugPrint("SMS Status: $status");
//         break;
//     }
//   }
// }
