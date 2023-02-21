import 'package:json_annotation/json_annotation.dart';

import 'reqresapidatamodel.dart';
import 'reqresapisupportmodel.dart';

part 'reqresapimodel.g.dart';

@JsonSerializable(explicitToJson: true)
class ReqResAPIModel {
  final ReqResAPIDataModel data;
  final ReqResAPISupportModel support;

  ReqResAPIModel({
    required this.data,
    required this.support,
  });

  // map -> model
  factory ReqResAPIModel.fromJson(Map<String, dynamic> json) =>
      _$ReqResAPIModelFromJson(json);

  // model -> map
  Map<String, dynamic> toJson() => _$ReqResAPIModelToJson(this);
}
