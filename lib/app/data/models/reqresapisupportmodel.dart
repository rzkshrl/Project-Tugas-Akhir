import 'package:json_annotation/json_annotation.dart';

part 'reqresapisupportmodel.g.dart';

@JsonSerializable()
class ReqResAPISupportModel {
  final String url;
  final String text;

  ReqResAPISupportModel({required this.url, required this.text});

  // map -> model
  factory ReqResAPISupportModel.fromJson(Map<String, dynamic> json) =>
      _$ReqResAPISupportModelFromJson(json);

  Map<String, dynamic> toJson() => _$ReqResAPISupportModelToJson(this);
}
