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

  UserModel(
      {this.uid,
      this.name,
      this.email,
      this.photoUrl,
      this.role,
      this.creationTime,
      this.lastSignInTime,
      this.bidang,
      this.pin});

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
        pin: data['pin']);
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
      "pin": pin
    };
    // data['uid'] = uid;
    // data['name'] = name;
    // data['email'] = email;
    // data['photoUrl'] = photoUrl;
    // data['roles'] = roles;
    // data['creationTime'] = creationTime;
    // data['lastSignInTime'] = lastSignInTime;
    // data['updatedTime'] = updatedTime;
    // return data;
  }
}
