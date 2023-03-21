// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'listallscanlogmodel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListAllScanlogModel _$ListAllScanlogModelFromJson(Map<String, dynamic> json) =>
    ListAllScanlogModel(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => AllScanlogModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ListAllScanlogModelToJson(
        ListAllScanlogModel instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
