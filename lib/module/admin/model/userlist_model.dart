

import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String email;
  final String? name;
  final String? phone;
  final String? district;
  final String? gender;
  final String? bloodGroup;
  final String? fcmToken;
  final int type;
  final dynamic age; // Can be int or empty string
  final Timestamp? createdAt;

  UserModel({
    required this.email,
    required this.type,
    this.name,
    this.phone,
    this.district,
    this.gender,
    this.bloodGroup,
    this.fcmToken,
    this.age,
    this.createdAt,
  });

  factory UserModel.fromMap(Map<String, dynamic> data) {
    return UserModel(
      email: data['email'] ?? '',
      type: data['type'] ?? 0,
      name: data['name'],
      phone: data['phone'],
      district: data['district'],
      gender: data['gender'],
      bloodGroup: data['blood_group'],
      fcmToken: data['fcm_token'],
      age: data['age'],
      createdAt: data['createdAt'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'type': type,
      'name': name,
      'phone': phone,
      'district': district,
      'gender': gender,
      'blood_group': bloodGroup,
      'fcm_token': fcmToken,
      'age': age,
      'createdAt': createdAt,
    };
  }
}
