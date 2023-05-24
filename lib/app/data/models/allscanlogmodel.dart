import 'dart:convert';

AllScanlogModel allScanlogModelFromJson(String str) =>
    AllScanlogModel.fromJson(json.decode(str));

String allScanlogModelToJson(AllScanlogModel data) =>
    json.encode(data.toJson());

List<AllScanlogModel> allScanlogList = [];

List<AllScanlogModel> fullScanlogList = [];

class AllScanlogModel {
  String? pin;
  int? workCode;
  String? sn;
  int? verifyMode;
  DateTime? scanDate;
  int? iOMode;

  AllScanlogModel(
      {this.pin,
      this.workCode,
      this.sn,
      this.verifyMode,
      this.scanDate,
      this.iOMode});

  factory AllScanlogModel.fromJson(Map<String, dynamic> json) {
    return (AllScanlogModel(
        pin: json['PIN'],
        workCode: json['WorkCode'],
        sn: json['SN'],
        verifyMode: json['VerifyMode'],
        scanDate: DateTime.parse(json['ScanDate']),
        iOMode: json['IOMode']));
  }

  Map<String, dynamic> toJson() {
    return {
      "pin": pin,
      "workCode": workCode,
      "sn": sn,
      "verifyMode": verifyMode,
      "scanDate": scanDate!.toIso8601String(),
      "iOMode": iOMode
    };
  }
}

class ScanInDayModel {
  DateTime? scan;

  ScanInDayModel({this.scan});

  factory ScanInDayModel.fromJson(Map<String, dynamic> json) {
    return ScanInDayModel(
      scan: DateTime.parse(json['scan']),
    );
  }
}

class PresenceModel {
  String? date;
  List<ScanInDayModel>? scanInDay;

  PresenceModel({this.date, this.scanInDay});

  factory PresenceModel.fromJson(Map<String, dynamic> json) {
    return PresenceModel(
      date: json['date'],
      scanInDay: (json['scanInDay'] as List<dynamic>)
          .map((item) => ScanInDayModel.fromJson(item))
          .toList(),
    );
  }
}

class PresensiKepgModel {
  String? pin;
  List<PresenceModel>? presence;

  PresensiKepgModel({this.pin, this.presence});

  factory PresensiKepgModel.fromJson(Map<String, dynamic> json) {
    return PresensiKepgModel(
      pin: json['pin'],
      presence: (json['presence'] as List<dynamic>)
          .map((item) => PresenceModel.fromJson(item))
          .toList(),
    );
  }
}
