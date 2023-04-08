import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

List<KepegawaianModel> kepegawaianList = [];

class PresensiModel {
  String? pin;
  DateTime? dateTime;
  String? status;

  PresensiModel({this.pin, this.dateTime, this.status});

  factory PresensiModel.fromJson(Map<String, dynamic> json) {
    return (PresensiModel(
      pin: json['pin'],
      dateTime: DateTime.parse(json['date_time']),
      status: json['status'],
    ));
  }

  Map<String, dynamic> toJson() {
    return {
      "pin": pin,
      "dateTime": dateTime!.toIso8601String(),
      "status": status,
    };
  }
}

class LiburModel {
  String? holidayName;
  DateTime? holidayDate;
  bool? isNationalHoliday;

  LiburModel({this.holidayName, this.holidayDate, this.isNationalHoliday});

  factory LiburModel.fromJson(Map<String, dynamic> json) {
    return (LiburModel(
      holidayName: json['holiday_name'],
      holidayDate: DateTime.parse(json['holiday_date']),
      isNationalHoliday: json['is_national_holiday'],
    ));
  }

  Map<String, dynamic> toJson() {
    return {
      "holidayName": holidayName,
      "holidayDate": holidayDate,
      "isNationalHoliday": isNationalHoliday,
    };
  }
}

class KepegawaianModel {
  String? pin;
  String? nip;
  String? nama;
  String? jadker;
  String? email;
  String? bidang;
  List<PresensiModel>? presensi;

  KepegawaianModel(
      {this.pin,
      this.nip,
      this.nama,
      this.jadker,
      this.email,
      this.bidang,
      this.presensi});

  factory KepegawaianModel.fromSnapshot(DocumentSnapshot json) {
    final data = json.data() as Map<String, dynamic>;
    final presensiRef = json.reference.collection('Presensi');
    return KepegawaianModel(
        pin: data['pin'],
        nip: data['nip'],
        nama: data['nama'],
        jadker: data['jadker'],
        email: data['email'],
        bidang: data['bidang'],
        presensi: []);
  }

  Future<void> loadPresensi() async {
    final presensiRef = FirebaseFirestore.instance
        .collection('Kepegawaian')
        .doc(pin)
        .collection('Presensi');
    final querySnapshot = await presensiRef.get();
    this.presensi = querySnapshot.docs
        .map((doc) => PresensiModel.fromJson(doc.data()))
        .toList();
  }
}
