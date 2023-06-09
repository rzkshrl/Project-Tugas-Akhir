// ignore_for_file: file_names

import '../data/models/firestorepengecualianmodel.dart';
import '../data/models/firestorescanlogmodel.dart';

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

bool isSameDay(DateTime date1, DateTime date2) {
  return date1.year == date2.year &&
      date1.month == date2.month &&
      date1.day == date2.day;
}

List<PengecualianIterableModel> generateDateRangePengecualian(
    List<PengecualianIterableModel> dateRange, PengecualianModel pengecualian) {
  DateTime startDate = pengecualian.dateStart!;
  DateTime endDate = pengecualian.dateEnd!;

  for (var date = startDate;
      date.isBefore(endDate) || date.isAtSameMomentAs(endDate);
      date = date.add(const Duration(days: 1))) {
    PengecualianIterableModel iterableModel = PengecualianIterableModel(
      nama: pengecualian.nama,
      statusPengecualian: pengecualian.statusPengecualian,
      date: date,
      id: pengecualian.id,
    );

    dateRange.add(iterableModel);
  }

  return dateRange;
}

String hitungTotal(List<String> list) {
  Duration total = const Duration();

  for (var keterlambatanFormatted in list) {
    var parts = keterlambatanFormatted.split(':');
    var hours = int.parse(parts[0]);
    var minutes = int.parse(parts[1]);

    var data = Duration(hours: hours, minutes: minutes);
    total += data;
  }

  return "${total.inHours.toString().padLeft(2, '0')}:${total.inMinutes.remainder(60).toString().padLeft(2, '0')}";
}
