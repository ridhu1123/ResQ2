import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:resq_application/widget/custom_snackbar.dart';

class AdminLoginController extends ChangeNotifier
 {
 FirebaseAuth firebaseAuth =FirebaseAuth.instance;
 FirebaseFirestore firebaseFirestore =FirebaseFirestore.instance;
TextEditingController emailController=TextEditingController();
TextEditingController passWordController=TextEditingController();
  bool isLoading=false;
 
//  Future<bool> userSignIn({int? userType}) async {
//     try {
//       isLoading = true;
//       notifyListeners();
//       final response = await firebaseAuth
//           .signInWithEmailAndPassword(
//             email: emailController.text,
//             password: passWordController.text,
//           );
//          if (response.user !=null) {
//            final userData=await firebaseFirestore.collection('users')
//         .doc(response.user?.uid)
//         .get();
//         if (userData['type']==2) {
//              clearControllers();
//           CustomSnackBar.show(title: '', message: 'SignIn successfull');
//           return true; 
//         }
//         log('Something went wrong');
//          CustomSnackBar.show(title: '', message: 'Login anthother user');
//         return false;
       
//          }
        
//            CustomSnackBar.show(title: '', message: 'Somethink went wrong');
//             isLoading = false;
//       notifyListeners();
//           return false;
         
    
//     } catch (e) {
      
//       isLoading = false;
//       notifyListeners();
//            CustomSnackBar.show(title: '', message: 'Somethink went wrong $e');
//       log('Somethinkwent wrong $e');
//       return false;
//     }
//   }
  Future<void>signOut()async{
   await firebaseAuth.signOut();
   
  }
  void clearControllers(){
    emailController.clear();
    passWordController.clear();
    notifyListeners();
  }

 }