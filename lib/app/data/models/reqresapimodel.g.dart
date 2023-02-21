// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reqresapimodel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReqResAPIModel _$ReqResAPIModelFromJson(Map<String, dynamic> json) =>
    ReqResAPIModel(
      data: ReqResAPIDataModel.fromJson(json['data'] as Map<String, dynamic>),
      support: ReqResAPISupportModel.fromJson(
          json['support'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ReqResAPIModelToJson(ReqResAPIModel instance) =>
    <String, dynamic>{
      'data': instance.data.toJson(),
      'support': instance.support.toJson(),
    };
