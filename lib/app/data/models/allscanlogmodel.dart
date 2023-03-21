import 'dart:convert';

AllScanlogModel allScanlogModelFromJson(String str) =>
    AllScanlogModel.fromJson(json.decode(str));

String allScanlogModelToJson(AllScanlogModel data) =>
    json.encode(data.toJson());

List<AllScanlogModel> allScanlogList = [];

class AllScanlogModel {
  String? pin;
  int? workCode;
  String? sn;
  int? verifyMode;
  String? scanDate;
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
        scanDate: json['ScanDate'],
        iOMode: json['IOMode']));
  }

  Map<String, dynamic> toJson() {
    return {
      "pin": pin,
      "workCode": workCode,
      "sn": sn,
      "verifyMode": verifyMode,
      "scanDate": scanDate,
      "iOMode": iOMode
    };
  }
}
