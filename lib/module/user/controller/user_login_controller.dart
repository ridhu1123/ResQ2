import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:resq_application/widget/custom_snackbar.dart';

class UserLoginController extends ChangeNotifier {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore firebaseFireStor = FirebaseFirestore.instance;
  TextEditingController emailController = TextEditingController();
  TextEditingController passWordController = TextEditingController();
  TextEditingController districtController = TextEditingController();
  bool isLoading = false;
  Future<void> userSignUp() async {
    try {
      isLoading = true;
      notifyListeners();
      final response = await firebaseAuth
          .createUserWithEmailAndPassword(
            email: emailController.text,
            password: passWordController.text,
          )
          .then((value) async{
            
            if (!(value.user!.emailVerified)) {
              firebaseAuth.currentUser!.sendEmailVerification();
                CustomSnackBar.show(title: '', message: 'SignUp successfull');
            }
            final uid=value.user?.uid;
              await FirebaseFirestore.instance.collection('users').doc(uid).set({
      'email': emailController.text,
      'type': 0, 
      'createdAt': FieldValue.serverTimestamp(),
      'name':'',
      'phone':'',
      'blood_group':'',
      'gender':'',
      'age':'',
      'district':districtController.text
    });
          });
      
        
      // log('Register response ${response.user}');
      clearControllers();
      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      notifyListeners();
       CustomSnackBar.show(title: '', message: 'Somethink went wrong $e');
      log('Somethinkwent wrong $e');
    }
  }

  Future<bool> userSignIn({int? userType}) async {
   
    try {
      isLoading = true;
      notifyListeners();
      final response = await firebaseAuth
          .signInWithEmailAndPassword(
            email: emailController.text,
            password: passWordController.text,
          );
   
    if (!(response.user?.emailVerified??false)) {
      log('email  is not verified');
      return false;
    }
         if (response.user !=null) {
           final userData=await firebaseFireStor.collection('users')
        .doc(response.user?.uid)
        .get();
        if (userData['type']==userType) {
             clearControllers();
          CustomSnackBar.show(title: '', message: 'SignIn successfull');
          return true; 
        }
         CustomSnackBar.show(title: '', message: 'Login anthother user');
        return false;
       
         }
        
           CustomSnackBar.show(title: '', message: 'Somethink went wrong');
            isLoading = false;
      notifyListeners();
          return false;
         
    
    } catch (e) {
      
      isLoading = false;
      notifyListeners();
           CustomSnackBar.show(title: '', message: 'Somethink went wrong $e');
      log('Somethinkwent wrong $e');
      return false;
    }
  }
  Future<bool> userSignOut()async{
    try {
      if (firebaseAuth.currentUser?.uid ==null) {
        return false;
      }
      await firebaseAuth.signOut();
      return true;
    } catch (e) {
      log('Something went wrong $e');
      return false;
    }
  }

  void clearControllers(){
    emailController.clear();
    passWordController.clear();
    notifyListeners();
  }
}
