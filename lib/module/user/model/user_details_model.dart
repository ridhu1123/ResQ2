// To parse this JSON data, do
//
//     final userDetailsModel = userDetailsModelFromJson(jsonString);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

UserDetailsModel userDetailsModelFromJson(String str) => UserDetailsModel.fromJson(json.decode(str));

String userDetailsModelToJson(UserDetailsModel data) => json.encode(data.toJson());

class UserDetailsModel {
  final Timestamp? createdAt;
  final String? gender;
  final String? phone;
  final String? district;
  final String? name;
  final String? bloodGroup;
  final int? type;
  final String? email;
  final String? age;

  UserDetailsModel({
    this.createdAt,
    this.gender,
    this.phone,
    this.district,
    this.name,
    this.bloodGroup,
    this.type,
    this.email,
    this.age,
  });

  factory UserDetailsModel.fromJson(Map<String, dynamic> json) {
    return UserDetailsModel(
      createdAt: json['createdAt'] as Timestamp?,
      gender: json['gender'],
      phone: json['phone'],
      district: json['district'],
      name: json['name'],
      bloodGroup: json['blood_group'],
      type: json['type'],
      email: json['email'],
      age: json['age'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'createdAt': createdAt?.toDate().toIso8601String(),
      'gender': gender,
      'phone': phone,
      'district': district,
      'name': name,
      'blood_group': bloodGroup,
      'type': type,
      'email': email,
      'age': age,
    };
  }
}