// ignore_for_file: unnecessary_overrides

import 'package:get/get.dart';

import '../../../data/models/firestorescanlogmodel.dart';

class RiwayatPresensiMobileController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  bool isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  List<GroupedPresensiModel> groupAttendanceData(List<PresensiModel> rawData) {
    List<GroupedPresensiModel> groupedData = [];
    GroupedPresensiModel? currentPresensi;

    for (var data in rawData) {
      String? pin = data.pin;
      DateTime? dateTime = data.dateTime;
      String? status = data.status;

      if (status == 'Masuk') {
        currentPresensi = GroupedPresensiModel(
          pin: pin,
          dateTimeMasuk: dateTime,
          dateTimeKeluar: DateTime.now(),
        );
        groupedData.add(currentPresensi);
      } else if (status == 'Keluar') {
        if (currentPresensi != null && currentPresensi.pin == pin) {
          currentPresensi.dateTimeKeluar = dateTime;
        }
      }
    }

    return groupedData;
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
