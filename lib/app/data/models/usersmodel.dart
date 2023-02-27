import 'package:json_annotation/json_annotation.dart';

part 'usersmodel.g.dart';

@JsonSerializable()
class UsersModel {
  String? uid;
  String? email;
  String? profile;
  String? password;
  String? role;

  UsersModel({this.uid, this.email, this.profile, this.password, this.role});

  // map -> model
  factory UsersModel.fromJson(Map<String, dynamic> json) =>
      _$UsersModelFromJson(json);

  Map<String, dynamic> toJson() => _$UsersModelToJson(this);
}
