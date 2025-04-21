import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AdminHomeController extends ChangeNotifier {
  AdminHomeController(){
    fetchAllFirstAids();
  }
FirebaseFirestore firebaseFirestore=FirebaseFirestore.instance;
List<Map<String, dynamic>> allData=[];
  List<String> adminHomeImage=[
    'assets/call_12870796.png',
    'assets/support_10204371.png',
    'assets/hand_10298011.png',
    'assets/firstaid.jpg',
    'assets/purchase-order-icon-9.jpg',
  ];
    List<String> adminHomeImageText=[
    'Requests',
    'Accepted Request',
    'Rejected Requests',
    'First Aids',
    'Orders'
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

Future<void>accpectResQ({Map<String, dynamic>? selectedData})async{
 try {
      isLoading=true;
      notifyListeners();
       await firebaseFirestore.collection('accpected_resq').doc().set(
      {
      'name':selectedData?['name'],
      'location':selectedData?['location'],
      'note':selectedData?['note'],
      'phone':selectedData?['phone'],
      'blood_group':selectedData?['blood_group'],
      'gender':selectedData?['location'],
      'age':selectedData?['gender'],
      'latlong':selectedData?['latlong'],
      'status':selectedData?['status'],
      'deliver_status':1
      }
      );
   await   removeResQ(selectedData: selectedData);
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
Future<void>rejectedResQ({Map<String, dynamic>? selectedData})async{
 try {
      isLoading=true;
      notifyListeners();
       await firebaseFirestore.collection('rejected_resq').doc().set(
      {
      'name':selectedData?['name'],
      'location':selectedData?['location'],
      'note':selectedData?['note'],
      'phone':selectedData?['phone'],
      'blood_group':selectedData?['blood_group'],
      'gender':selectedData?['location'],
      'age':selectedData?['gender'],
      'latlong':selectedData?['latlong'],
      'status':selectedData?['status'],
      'deliver_status':-1
      }
      );
await removeResQ(selectedData: selectedData);
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
Future<void>removeResQ({Map<String, dynamic>? selectedData})async{
 try {
       await firebaseFirestore.collection('resQ details').doc(selectedData?['id']).delete();
       log('delete seccussfull');
    } catch (e) {
      log('Something went wrong $e');
    }
}
List<String> firstAidImage=[
    'assets/firstaid.jpg',
    'assets/food.jpg',
    'assets/knife.jpg',
    'assets/rope.jpg',
    'assets/water.jpg'
  ];
// Future<void> addFirstAid(String image,String count)async{
//     await firebaseFirestore.collection('first_aids').doc().set(
//       {
//       'image_url':image,
//       'count':count,
//        'captions':''
//       }
//       );
//       // clearController();
//       isLoading=false;
//       notifyListeners();
//       // log('resQ response ${response}')
  
// }
List<Map<String,dynamic>>fistAidsList=[];
Future<void> fetchAllFirstAids() async {
  try {
    isLoading = true;
    notifyListeners();

    final querySnapshot = await firebaseFirestore
        .collection('first_aids')
        .get(); // Fetch all documents

    // Convert each document to a map and collect them in a list
     fistAidsList = querySnapshot.docs
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

bool buyLoad=false;
Future<void>changeFirsAidCount({String? id,int changeCount=0})async{
    
   buyLoad=true;
   notifyListeners();
   await firebaseFirestore.collection('first_aids').doc(id).update(
      {
      'ordered_count':changeCount,
      
      }
      );
buyLoad=false;
notifyListeners();
}

Future<void>removeFirsAidCount({String? id,int count=0})async{
    
   buyLoad=true;
   notifyListeners();
   await firebaseFirestore.collection('first_aids').doc(id).update(
      {
      'count':count,
      }
      );
      fetchAllFirstAids();
buyLoad=false;
notifyListeners();
}
}