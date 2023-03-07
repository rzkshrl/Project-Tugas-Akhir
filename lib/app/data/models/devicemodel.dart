import 'dart:convert';

DeviceModel userModelFromJson(String str) =>
    DeviceModel.fromJson(json.decode(str));

String userModelToJson(DeviceModel data) => json.encode(data.toJson());

class DeviceModel {
  int? deviceSn;
  String? serverIp;
  int? serverPort;

  DeviceModel({this.deviceSn, this.serverIp, this.serverPort});

  factory DeviceModel.fromJson(Map<String, dynamic> json) {
    return DeviceModel(
        deviceSn: json['device_sn'],
        serverIp: json['server_ip'],
        serverPort: json['server_port']);
  }

  Map<String, dynamic> toJson() {
    return {
      "deviceSn": deviceSn,
      "serverIp": serverIp,
      "serverPort": serverPort,
    };
  }
}
