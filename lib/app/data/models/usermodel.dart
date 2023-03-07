import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  String? uid;
  String? name;
  String? email;
  String? photoUrl;
  String? password;
  String? role;
  String? creationTime;
  String? lastSignInTime;

  UserModel(
      {this.uid,
      this.name,
      this.email,
      this.photoUrl,
      this.password,
      this.role,
      this.creationTime,
      this.lastSignInTime});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        uid: json['uid'],
        name: json['name'],
        email: json['email'],
        photoUrl: json['photoUrl'],
        password: json['password'],
        role: json['roles'],
        creationTime: json['creationTime'],
        lastSignInTime: json['lastSignInTime']);
  }

  Map<String, dynamic> toJson() {
    return {
      "uid": uid,
      "name": name,
      "email": email,
      "photoUrl": photoUrl,
      "password": password,
      "role": role,
      "creationTime": creationTime,
      "lastSignInTime": lastSignInTime
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
