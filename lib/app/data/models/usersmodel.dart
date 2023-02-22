import 'package:json_annotation/json_annotation.dart';

part 'usersmodel.g.dart';

@JsonSerializable(ignoreUnannotated: true)
class UsersModel {
  final String uid;
  final String email;
  final String profile;
  final String password;
  final String role;

  UsersModel(
      {required this.uid,
      required this.email,
      required this.profile,
      required this.password,
      required this.role});

  // map -> model
  factory UsersModel.fromJson(Map<String, dynamic> json) =>
      _$UsersModelFromJson(json);

  Map<String, dynamic> toJson() => _$UsersModelToJson(this);
}
