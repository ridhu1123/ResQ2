import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AcceptedResqController extends ChangeNotifier {
FirebaseFirestore firebaseFirestore=FirebaseFirestore.instance;
List <Map<String, dynamic>> allData=[];
 bool isLoading=false;
  Future<void> fetchAllAccpectedResq
  () async {
  try {
    isLoading = true;
    // notifyListeners();

    final querySnapshot = await firebaseFirestore
        .collection('accpected_resq')
        .get(); // Fetch all documents

    // Convert each document to a map and collect them in a list
     allData = querySnapshot.docs
        .map((doc) => {
              'id': doc.id, // optional: include document ID
              ...doc.data()
            })
        .toList();
          isLoading = false;
    notifyListeners();
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
Future<void>statusUpdate({int? status,String? id})async{
 try {
      isLoading=true;
      notifyListeners();
       await firebaseFirestore.collection('accpected_resq').doc(id).update(
      {
      'deliver_status':status
      }
      );
  //  await   removeResQ(selectedData: selectedData);
      // clearController();
      isLoading=false;
      notifyListeners();
      // log('resQ response ${response}')
    } catch (e) {
       isLoading=false;
      notifyListeners();
      log('Something went wrong $e');
    }
}
bool chipState=false;
void chipChange(){
//  ch
}

}