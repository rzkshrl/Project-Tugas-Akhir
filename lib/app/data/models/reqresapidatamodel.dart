import 'package:json_annotation/json_annotation.dart';

part 'reqresapidatamodel.g.dart';

@JsonSerializable()
class ReqResAPIDataModel {
  final int id;
  final String email;
  final String first_name;
  final String last_name;
  final String avatar;

  ReqResAPIDataModel(
      {required this.id,
      required this.email,
      required this.first_name,
      required this.last_name,
      required this.avatar});

  // map -> model
  factory ReqResAPIDataModel.fromJson(Map<String, dynamic> json) =>
      _$ReqResAPIDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$ReqResAPIDataModelToJson(this);
}
