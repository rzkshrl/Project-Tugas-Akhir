import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

import 'allscanlogmodel.dart';

part 'listallscanlogmodel.g.dart';

@JsonSerializable()
class ListAllScanlogModel {
  List<AllScanlogModel>? data;

  ListAllScanlogModel({this.data});

  factory ListAllScanlogModel.fromJson(Map<String, dynamic> json) =>
      _$ListAllScanlogModelFromJson(json);

  Map<String, dynamic> toJson() => _$ListAllScanlogModelToJson(this);
}
