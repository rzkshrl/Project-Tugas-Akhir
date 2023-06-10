import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  String? uid;
  String? name;
  String? email;
  String? photoUrl;
  String? role;
  String? creationTime;
  String? lastSignInTime;
  String? bidang;
  String? pin;
  String? status;

  UserModel(
      {this.uid,
      this.name,
      this.email,
      this.photoUrl,
      this.role,
      this.creationTime,
      this.lastSignInTime,
      this.bidang,
      this.pin,
      this.status});

  factory UserModel.fromJson(DocumentSnapshot json) {
    final data = json.data() as Map<String, dynamic>;
    return UserModel(
        uid: data['uid'],
        name: data['name'],
        email: data['email'],
        photoUrl: data['profile'],
        role: data['role'],
        creationTime: data['creationTime'],
        lastSignInTime: data['lastSignInDate'],
        bidang: data['bidang'],
        pin: data['pin'],
        status: data['status']);
  }

  factory UserModel.fromJson2(Map<String, dynamic> data) {
    return UserModel(
        uid: data['uid'],
        name: data['name'],
        email: data['email'],
        photoUrl: data['profile'],
        role: data['role'],
        creationTime: data['creationTime'],
        lastSignInTime: data['lastSignInDate'],
        bidang: data['bidang'],
        pin: data['pin'],
        status: data['status']);
  }

  Map<String, dynamic> toJson() {
    return {
      "uid": uid,
      "name": name,
      "email": email,
      "photoUrl": photoUrl,
      "role": role,
      "creationTime": creationTime,
      "lastSignInTime": lastSignInTime,
      "bidang": bidang,
      "pin": pin,
      "status": status
    };
  }
}
