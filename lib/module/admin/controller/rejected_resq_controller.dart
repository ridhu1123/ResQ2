import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class RejectedReqController extends ChangeNotifier {
FirebaseFirestore firebaseFirestore=FirebaseFirestore.instance;
List <Map<String, dynamic>> allData=[];
 bool isLoading=false;
  Future<void> fetchAllCompletedResq() async {
  try {
    isLoading = true;
    // notifyListeners();

    final querySnapshot = await firebaseFirestore
        .collection('rejected_resq')
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