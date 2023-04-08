import 'dart:convert';

DeviceModel userModelFromJson(String str) =>
    DeviceModel.fromJson(json.decode(str));

String userModelToJson(DeviceModel data) => json.encode(data.toJson());

class DeviceModel {
  int? deviceSn;
  String? serverIp;
  int? serverPort;
  String? allPresensi;
  String? newPresensi;

  DeviceModel({
    this.deviceSn,
    this.serverIp,
    this.serverPort,
    this.allPresensi,
    this.newPresensi,
  });

  factory DeviceModel.fromJson(Map<String, dynamic> json) {
    return DeviceModel(
      deviceSn: json['device_sn'],
      serverIp: json['server_ip'],
      serverPort: json['server_port'],
      allPresensi: json['allPresensi'],
      newPresensi: json['newPresensi'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "deviceSn": deviceSn,
      "serverIp": serverIp,
      "serverPort": serverPort,
      "allPresensi": allPresensi,
      "newPresensi": newPresensi,
    };
  }
}
