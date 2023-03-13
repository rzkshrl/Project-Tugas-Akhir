import 'dart:convert';

DeviceInfoModel deviceInfoModelFromJson(String str) =>
    DeviceInfoModel.fromJson(json.decode(str));

String deviceInfoModelToJson(DeviceInfoModel data) =>
    json.encode(data.toJson());

class DeviceInfoModel {
  String? admin;
  String? pwd;
  String? jam;
  String? newOperasional;
  String? allPresensi;
  String? newPresensi;
  String? allOperasional;
  String? fp;
  String? vein;
  String? user;
  String? face;
  String? card;

  DeviceInfoModel(
      {this.admin,
      this.pwd,
      this.jam,
      this.newOperasional,
      this.allPresensi,
      this.newPresensi,
      this.allOperasional,
      this.fp,
      this.vein,
      this.user,
      this.face,
      this.card});

  factory DeviceInfoModel.fromJson(Map<String, dynamic> json) {
    return DeviceInfoModel(
        admin: json['Admin'],
        pwd: json['PWD'],
        jam: json['Jam'],
        newOperasional: json['New Operasional'],
        allPresensi: json['All Presensi'],
        newPresensi: json['New Presensi'],
        allOperasional: json['All Operasional'],
        fp: json['FP'],
        vein: json['Vein'],
        user: json['User'],
        face: json['Face'],
        card: json['CARD']);
  }

  Map<String, dynamic> toJson() {
    return {
      "admin": admin,
      "pwd": pwd,
      "jam": jam,
      "newOperasional": newOperasional,
      "allPresensi": allPresensi,
      "newPresensi": newPresensi,
      "allOperasional": allOperasional,
      "fp": fp,
      "vein": vein,
      "user": user,
      "face": face,
      "card": card,
    };
  }
}
