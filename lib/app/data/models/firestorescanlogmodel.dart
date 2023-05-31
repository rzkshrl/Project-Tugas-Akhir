import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

List<KepegawaianModel> kepegawaianList = [];
List<PresensiModel> presensiList = [];
List<LiburModel> liburList = [];

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

class GroupedPresensiModel {
  String? pin;
  DateTime? dateTimeMasuk;
  DateTime? dateTimeKeluar;

  GroupedPresensiModel({this.pin, this.dateTimeMasuk, this.dateTimeKeluar});
}

class LiburModel {
  String? holidayName;
  String? holidayDate;
  bool? isNationalDay;

  LiburModel({this.holidayName, this.holidayDate, this.isNationalDay});

  factory LiburModel.fromJson(Map<String, dynamic> json) {
    return (LiburModel(
        holidayName: json['holiday_name'],
        holidayDate: json['holiday_date'],
        isNationalDay: json['is_national_holiday']));
  }

  Map<String, dynamic> toJson() {
    return {
      "holiday_name": holidayName,
      "holiday_date": holidayDate,
      "is_national_holiday": isNationalDay
    };
  }
}

class CalendarEvent {
  final String eventName;
  final DateTime from;
  final DateTime to;
  final Color background;
  final bool isAllDay;

  CalendarEvent({
    required this.eventName,
    required this.from,
    required this.to,
    required this.background,
    required this.isAllDay,
  });
}

class KepegawaianModel {
  String? pin;
  String? nip;
  String? nama;
  String? kepegawaian;

  String? bidang;

  KepegawaianModel(
      {this.pin, this.nip, this.nama, this.kepegawaian, this.bidang});

  factory KepegawaianModel.fromSnapshot(DocumentSnapshot json) {
    final data = json.data() as Map<String, dynamic>;

    return KepegawaianModel(
      pin: data['pin'],
      nip: data['nip'],
      nama: data['nama'],
      kepegawaian: data['kepegawaian'],
      bidang: data['bidang'],
    );
  }

  // Future<void> loadPresensi() async {
  //   final presensiRef = FirebaseFirestore.instance
  //       .collection('Kepegawaian')
  //       .doc(pin)
  //       .collection('Presensi');
  //   final querySnapshot = await presensiRef.get();
  //   this.presensi = querySnapshot.docs
  //       .map((doc) => PresensiModel.fromJson(doc.data()))
  //       .toList();
  // }
}
