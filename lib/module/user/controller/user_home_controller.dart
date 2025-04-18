
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserHomeController extends ChangeNotifier {
  UserHomeController(){
    getUserDetails();

  }
   
  FirebaseFirestore firebaseFirestore=FirebaseFirestore.instance;
  FirebaseAuth firebaseAuth=FirebaseAuth.instance;
  TextEditingController noteController=TextEditingController();
  TextEditingController nameController=TextEditingController();
  TextEditingController locationController=TextEditingController();
  TextEditingController phoneController=TextEditingController();
  TextEditingController bloodGroupController=TextEditingController();
  TextEditingController genderController=TextEditingController();
  TextEditingController ageController=TextEditingController();
  List<String> firstAidImage=[
    'assets/firstaid.jpg',
    'assets/food.jpg',
    'assets/knife.jpg',
    'assets/rope.jpg',
    'assets/water.jpg'
  ];
  bool isLoading=false;
  int bottomIndex=0;
  void bottomNavigationChange(int index){
   bottomIndex=index;
   notifyListeners();
  }

  Future<void> saveResqDetails()async{
    try {
      isLoading=true;
      notifyListeners();
      final response= await firebaseFirestore.collection('resQ details').doc().set(
      {
      'name':nameController.text,
      'location':locationController.text,
      'note':noteController.text,

      }
      );
      clearController();
      isLoading=false;
      notifyListeners();
      // log('resQ response ${response}')
    } catch (e) {
       isLoading=false;
      notifyListeners();
      log('Something went wrong $e');
    }
  }

   Future<void> updateUserDetails()async{
    final uid= await firebaseAuth.currentUser?.uid;
    try {
      isLoading=true;
      notifyListeners();
      final response= await firebaseFirestore.collection('users').doc(uid).update(
      {
      'name':nameController.text,
      'phone':phoneController.text,
      'blood_group':bloodGroupController.text,
      'gender':genderController.text,
      'age':ageController.text
      }
      );
      clearController();
      isLoading=false;
      notifyListeners();
      // log('resQ response ${response}')
    } catch (e) {
       isLoading=false;
      notifyListeners();
      log('Something went wrong $e');
    }
  }
  
 Future<void>getUserDetails() async{
    final uid= await firebaseAuth.currentUser?.uid;

  try {
    final response= await firebaseFirestore.collection('users').doc(uid).get();
    log('user details $response');
  } catch (e) {
      log('Something went wrong $e');
  }
 }

 void clearController(){
  noteController.clear();
  nameController.clear();
  locationController.clear();
  notifyListeners();
 } 
}