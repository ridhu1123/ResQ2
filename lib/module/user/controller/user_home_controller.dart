
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart' as AppSettings;
import 'package:resq_application/module/user/model/user_details_model.dart';

class UserHomeController extends ChangeNotifier {
  UserHomeController(){
    getUserDetails();

  }
   
  FirebaseFirestore firebaseFirestore=FirebaseFirestore.instance;
  FirebaseAuth firebaseAuth=FirebaseAuth.instance;
  Position? currentPosition; // nullable reactive position
  bool isLoadingLocation =false;
  String? locationError;
  String? latlong;
  String? streetName;
  String? localityName;
  TextEditingController noteController=TextEditingController();
  TextEditingController nameController=TextEditingController();
  TextEditingController locationController=TextEditingController();
  TextEditingController phoneController=TextEditingController();
  TextEditingController bloodGroupController=TextEditingController();
  TextEditingController genderController=TextEditingController();
  TextEditingController ageController=TextEditingController();
  String? name;
  String?note;
  String? location;
  UserDetailsModel? userDetails;
  String status='Safe';
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
  //0 - help requested
  //1 - admin accpected
  //-1 - rejected
  //2 - on the way
  //3 - help deliverd
  Future<void> saveResqDetails()async{
    try {
      isLoading=true;
      notifyListeners();
       await firebaseFirestore.collection('resQ details').doc().set(
      {
      'name':name,
      'location':location,
      'note':note,
      'phone':userDetails?.phone,
      'blood_group':userDetails?.bloodGroup,
      'gender':userDetails?.gender,
      'age':userDetails?.age,
      'latlong':latlong,
      'status':status,
      'deliver_status':0
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
  bool isUpdateLoading=false;
   Future<void> updateUserDetails()async{
    final uid= firebaseAuth.currentUser?.uid;
    try {
      isUpdateLoading=true;
      notifyListeners();
      await firebaseFirestore.collection('users').doc(uid).update(
      {
      'name':nameController.text,
      'phone':phoneController.text,
      'blood_group':bloodGroupController.text,
      'gender':genderController.text,
      'age':ageController.text
      }
      );
      log('Succefully updated ');
      clearController();
      isUpdateLoading=false;
      notifyListeners();
      // log('resQ response ${response}')
    } catch (e) {
       isUpdateLoading=false;
      notifyListeners();
      log('Something went wrong $e');
    }
  }
  
Future<void> getUserDetails() async {
  final uid = firebaseAuth.currentUser?.uid;

  if (uid == null) {
    log('User is not logged in');
    return;
  }

  try {
    final doc = await firebaseFirestore.collection('users').doc(uid).get();
    final data = doc.data();

    if (data != null) {
      userDetails = UserDetailsModel.fromJson(data); 
      log('User Name: ${userDetails?.name}');
    } else {
      log('No user document found.');
    }
  } catch (e) {
    log('Something went wrong $e');
  }
}
 void changeStatus() {
    if (status == 'Safe') {
      status = 'Mild';
      notifyListeners();
    } else if (status == 'Mild') {
      status = 'Severe';
      notifyListeners();
    } else {
      status = 'Safe';
      notifyListeners();
    }
    print('Status changed to: $status');
  }

 void clearController(){
  status='Safe';
  noteController.clear();
  nameController.clear();
  locationController.clear();
  ageController.clear();
  phoneController.clear();
  bloodGroupController.clear();
  genderController.clear();

  notifyListeners();
 } 

 Future<void> fetchCurrentLocation() async {
    isLoadingLocation= true;
    locationError= '';
    streetName = '';
    localityName = '';

    try {
      // Check if location services are enabled
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        locationError = 'Location services are disabled.';
        isLoadingLocation = false;
        notifyListeners();
        return;
      }

      // Check and request permissions
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          locationError = 'Location permission is denied';
          isLoadingLocation = false;
          notifyListeners();
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        locationError = 'Location permission is permanently denied. Please enable it from app settings.';
        await AppSettings.openAppSettings();
        isLoadingLocation = false;
        notifyListeners();
        return;
      }

      // Get current position
      currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      log('Current position: ${currentPosition?.latitude}');
      latlong='${currentPosition?.latitude},${currentPosition?.longitude}';
      // Reverse geocoding
    List<Placemark> placemarks = await placemarkFromCoordinates(
  currentPosition!.latitude,
  currentPosition!.longitude,
);

if (placemarks.isNotEmpty) {
  final place = placemarks.first;
  streetName = '${place.street},${place.locality},${place.administrativeArea}';
  // localityName.value = place.locality ?? '';
  // log('Street: ${streetName.value}, Locality: ${localityName.value}');
   log('Current position: $streetName');
  isLoadingLocation = false;
  notifyListeners();
}
isLoadingLocation = false;
notifyListeners();

    } catch (e) {
      locationError = 'Failed to get location: $e';
      isLoadingLocation = false;
      notifyListeners();
      // print('Location fetch error: $e');
    } finally {
      isLoadingLocation = false;
      notifyListeners();
    }
  }
}