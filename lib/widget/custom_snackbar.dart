import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:resq_application/constants/app_constants.dart';

import 'package:flutter/material.dart';

class CustomSnackBar {
  static final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();


  static GlobalKey<ScaffoldMessengerState> get scaffoldMessengerKey =>
      _scaffoldMessengerKey;


  static void success(String message, {Color? backgroundColor,int seconds = 3}) {
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
        duration:  Duration(seconds: seconds),
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




class CustomAlertPopUp {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  static late AudioPlayer _audioPlayer;

  // Method to play sound
  static Future<void> _playNotificationSound() async {
    try {
      _audioPlayer = AudioPlayer();
      await _audioPlayer.play(AssetSource('songs/notification_sound.mp3')); // Your audio file path
    } catch (e) {
      print("⚠️ Error playing sound: $e");
    }
  }

  // Method to stop sound
  static Future<void> _stopNotificationSound() async {
    try {
      await _audioPlayer.stop();
    } catch (e) {
      print("⚠️ Error stopping sound: $e");
    }
  }

  // Method to show the alert dialog with the "STOP" button
  static void showPersistentDialog({String? message}) {
    // Play the notification sound when the dialog is shown
    _playNotificationSound();

    showDialog(
      context: navigatorKey.currentContext!,
      barrierDismissible: false, // Prevent closing by tapping outside
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => false, // Disable back button
          child: Dialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: SizedBox(
              height: 250,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                   '🚨 Emergency Alert',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Text(
                      message ?? '',
                      style: TextStyle(fontWeight: FontWeight.bold),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                          SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      _stopNotificationSound(); // Stop the sound when the button is pressed
                      Navigator.of(context).pop(); // Close the dialog
                    },
                    style: ElevatedButton.styleFrom(
                      shape: CircleBorder(),
                      padding: EdgeInsets.all(40),
                      backgroundColor: Colors.red,
                    ),
                    child: Text(
                      'STOP',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}




