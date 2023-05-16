import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../data/models/firestorescanlogmodel.dart';

class CalendarsController extends GetxController {
  String? pin;
  CalendarsController(this.pin);
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final CalendarController controller = CalendarController();
  final dio = Dio();

  Color? get appointmentColor => Colors.yellow;

  TextStyle get appointmentTextStyle => TextStyle(
        color: Colors.red,
        fontWeight: FontWeight.bold,
      );

  Stream<QuerySnapshot> getPresence() async* {
    yield* firestore
        .collection('Kepegawaian')
        .doc(pin)
        .collection('Presensi')
        .snapshots();
  }

  Future<List<PresensiModel>> getPresensiData() async {
    print('PIN DARI VIEW : $pin');
    QuerySnapshot<Map<String, dynamic>> presensiSnapshot = await firestore
        .collection('Kepegawaian')
        .doc(pin)
        .collection('Presensi')
        .get();

    List<PresensiModel> presensiData = [];

    for (var doc in presensiSnapshot.docs) {
      PresensiModel presensi = PresensiModel.fromJson(doc.data());
      presensiData.add(presensi);
    }

    return presensiData;
  }

  int getCurrentYear(CalendarController _calendarController) {
    DateTime? _visibleDate = _calendarController.displayDate;
    return _visibleDate!.year;
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
