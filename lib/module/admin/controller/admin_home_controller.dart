import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AdminHomeController extends ChangeNotifier {
FirebaseFirestore firebaseFirestore=FirebaseFirestore.instance;
List<Map<String, dynamic>> allData=[];
  List<String> adminHomeImage=[
    'assets/call_12870796.png',
    'assets/support_10204371.png',
    'assets/hand_10298011.png',
    'assets/firstaid.jpg'
  ];
    List<String> adminHomeImageText=[
    'Requests',
    'Completed Request',
    'Rejected Requests',
    'First Aids'
  ];

  Future<void> openGoogleMaps(String latLong) async {
    final parts = latLong.split(',');

    if (parts.length == 2) {
      final lat = double.parse(parts[0].trim());
      final lng = double.parse(parts[1].trim());
  final Uri googleMapUrl = Uri.parse('https://www.google.com/maps/search/?api=1&query=$lat,$lng');
  
  if (await canLaunchUrl(googleMapUrl)) {
    await launchUrl(googleMapUrl, mode: LaunchMode.externalApplication);
  } else {
    throw 'Could not open the map.';
  }
}

}

bool isLoading=false;
Future<void> fetchAllUsers() async {
  try {
    isLoading = true;
    notifyListeners();

    final querySnapshot = await firebaseFirestore
        .collection('resQ details')
        .get(); // Fetch all documents

    // Convert each document to a map and collect them in a list
     allData = querySnapshot.docs
        .map((doc) => {
              'id': doc.id, // optional: include document ID
              ...doc.data()
            })
        .toList();

    // print('Fetched all users: $allData');

    // You can now assign this to a variable like allUsers
    // allUsers.value = allData;

  } catch (e) {
    // print('Error fetching users: $e');
  } finally {
    isLoading = false;
    notifyListeners();
  }
}



}