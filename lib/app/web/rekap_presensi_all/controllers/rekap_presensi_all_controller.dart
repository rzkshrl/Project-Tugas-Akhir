// ignore_for_file: unnecessary_overrides

import 'package:get/get.dart';
import 'package:intl/intl.dart';

class RekapPresensiAllController extends GetxController {
  DateTime? start;
  final end = DateTime.now().obs;
  final dateFormatter = DateFormat('d MMMM yyyy', 'id-ID');
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

  void pickRangeDate(DateTime dateTime, DateTime dateTime2) {}
}
