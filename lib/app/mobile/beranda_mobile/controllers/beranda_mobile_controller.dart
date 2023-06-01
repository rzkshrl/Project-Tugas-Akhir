// ignore_for_file: unnecessary_overrides

import 'package:get/get.dart';

import '../views/beranda_mobile_view.dart';

class BerandaMobileController extends GetxController {
  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  final List<Attendance> _attendanceData = [
    Attendance('Hadir', 95, '95%'),
    Attendance('Tidak Hadir', 5, '5%'),
    // Tambahkan data lainnya sesuai kebutuhan
  ];

  List<Attendance> get attendanceData => _attendanceData;

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
