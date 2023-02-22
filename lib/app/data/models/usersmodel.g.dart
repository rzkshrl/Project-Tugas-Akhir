// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'usersmodel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UsersModel _$UsersModelFromJson(Map<String, dynamic> json) => UsersModel(
      uid: json['uid'] as String,
      email: json['email'] as String,
      profile: json['profile'] as String,
      password: json['password'] as String,
      role: json['role'] as String,
    );

Map<String, dynamic> _$UsersModelToJson(UsersModel instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'email': instance.email,
      'profile': instance.profile,
      'password': instance.password,
      'role': instance.role,
    };
