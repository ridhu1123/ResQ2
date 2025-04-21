import 'package:flutter/material.dart';
import 'package:resq_application/constants/app_constants.dart';

import 'package:flutter/material.dart';

class CustomSnackBar {
  static final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();


  static GlobalKey<ScaffoldMessengerState> get scaffoldMessengerKey =>
      _scaffoldMessengerKey;


  static void success(String message, {Color? backgroundColor}) {
    _scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        content: Text(
          message,
         style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.white,
            ),
        ),
        backgroundColor: backgroundColor ?? Colors.green,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        duration: const Duration(seconds: 3),
      ),
    );
  }


    static void error(String message, {Color? backgroundColor}) {
    _scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        content: Text(
          message,
           style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.white,
            ),
        ),
        backgroundColor: backgroundColor ?? Colors.red,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        duration: const Duration(seconds: 3),
      ),
    );
  }
}

// class CustomSnackBar {
//   static void show({
//     required String title,
//     required String message,
//   }) {
//     final context = AppConstants. rootScaffoldMessengerKey.currentState?.overlay?.context;
//     if (context == null) {
 
//       return;
//     }

//     final snackBar = SnackBar(
//       behavior: SnackBarBehavior.floating,
//       backgroundColor: Colors.black87,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(12),
//       ),
//       margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//       duration: const Duration(seconds: 3),
//       content: Column(
//         mainAxisSize: MainAxisSize.min,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             title,
            // style: const TextStyle(
            //   fontWeight: FontWeight.bold,
            //   fontSize: 16,
            //   color: Colors.white,
            // ),
//           ),
//           const SizedBox(height: 4),
//           Text(
//             message,
//             style: const TextStyle(color: Colors.white),
//           ),
//         ],
//       ),
//     );

//     ScaffoldMessenger.of(context).showSnackBar(snackBar);
//   }
// }


// class CustomSnackBar {
//   static void show({
//     required String title,
//     required String message,
//   }) {
//     final snackBar = SnackBar(
//       behavior: SnackBarBehavior.floating,
//       backgroundColor: Colors.black87,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(12),
//       ),
//       margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//       duration: const Duration(seconds: 3),
//       content: Column(
//         mainAxisSize: MainAxisSize.min,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             title,
//             style: const TextStyle(
//               fontWeight: FontWeight.bold,
//               fontSize: 16,
//               color: Colors.white,
//             ),
//           ),
//           const SizedBox(height: 4),
//           Text(
//             message,
//             style: const TextStyle(color: Colors.white),
//           ),
//         ],
//       ),
//     );

// //  AppConstants(). rootScaffoldMessengerKey.currentState
// //       ?..hideCurrentSnackBar()
// //       ..s(snackBar);
//   }
// }
