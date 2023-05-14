import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:intl/intl.dart';
import 'package:googleapis/calendar/v3.dart' as cal;
import 'package:googleapis_auth/googleapis_auth.dart' as auth;
import 'package:project_tugas_akhir/app/data/models/firestorehariliburmodel.dart';
import 'package:project_tugas_akhir/app/utils/holidayDTS.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:url_launcher/url_launcher.dart';

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

  void calendarTapped(CalendarTapDetails calendarTapDetails) {
    if (calendarTapDetails.targetElement == CalendarElement.appointment) {
      final Appointment appointment = calendarTapDetails.appointments![0];
      showAppointmentDetail(appointment);
    }
  }

  void showAppointmentDetail(Appointment appointment) {
    final DateTime startTime = appointment.startTime;
    final DateTime endTime = appointment.endTime;
    final String subject = appointment.subject;
    final Color color = appointment.color;
  }

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
