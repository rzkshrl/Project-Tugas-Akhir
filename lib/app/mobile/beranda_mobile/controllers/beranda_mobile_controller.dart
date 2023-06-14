// ignore_for_file: unnecessary_overrides, invalid_use_of_protected_member, unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../controller/auth_controller.dart';
import '../../../data/models/firestorehariliburmodel.dart';
import '../../../data/models/firestorejamkerjamodel.dart';
import '../../../data/models/firestorepengecualianmodel.dart';
import '../../../data/models/firestorescanlogmodel.dart';
import '../../../utils/fungsiRekap.dart';

class BerandaMobileController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  final authC = Get.put(AuthController());
  var pin = ''.obs;

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  List<KepegawaianModel> kepegawaianList = [];
  List<HolidayModel> holidayList = [];
  List<JamKerjaModel> jamKerjaList = [];
  List<PengecualianModel> pengecualianList = [];
  List<PengecualianIterableModel> pengecualianRangeList = [];
  var percentageList = <PercentageModel>[].obs;

  List<String> keterlambatanList = [];
  List<String> pulangLebihAwalList = [];

  final now = DateTime.now();
  DateTime? start;
  final end = DateTime.now().obs;
  final previousMonth = DateTime(
      DateTime.now().year, DateTime.now().month - 1, DateTime.now().day);
  final dateFormatter = DateFormat('MMMM', 'id-ID');
  int totalKeterlambatanInMinutes = 0;
  int totalPulangLebihAwalInMinutes = 0;
  int totalDurasiPresensiInMinutes = 0;

  void hitungKeterlambatanPulangLebihAwal(
      List<GroupedPresensiModel> presensiList, KepegawaianModel kepgData) {
    keterlambatanList.clear();
    pulangLebihAwalList.clear();

    for (var presensi in presensiList) {
      JamKerjaModel jamKerja;
      var hari = DateFormat.EEEE('id_ID').format(presensi.dateTimeMasuk!);

      try {
        jamKerja = jamKerjaList.firstWhere(
          (jk) => jk.hariKerja == hari && jk.kepg == kepgData.kepegawaian,
        );
      } catch (e) {
        if (kDebugMode) {
          print("JamKerjaModel tidak ditemukan");
        }
        return;
      }

      // ignore: unnecessary_null_comparison
      if (jamKerja != null) {
        var jadwalMasuk = DateTime.parse(
            "${presensi.dateTimeMasuk?.toIso8601String().substring(0, 10)} ${jamKerja.jadwalMasuk}");
        var jadwalKeluar = DateTime.parse(
            "${presensi.dateTimeKeluar?.toIso8601String().substring(0, 10)} ${jamKerja.jadwalKeluar}");

        if (presensi.dateTimeMasuk != null &&
            presensi.dateTimeMasuk!.hour != 0 &&
            presensi.dateTimeMasuk!.minute != 0 &&
            presensi.dateTimeMasuk!.isAfter(jadwalMasuk)) {
          var keterlambatan = presensi.dateTimeMasuk!.difference(jadwalMasuk);
          var keterlambatanInMinutes = keterlambatan.inMinutes;
          var keterlambatanFormatted =
              "${keterlambatan.inHours.toString().padLeft(2, '0')}:${keterlambatan.inMinutes.remainder(60).toString().padLeft(2, '0')}";
          keterlambatanList.add(keterlambatanFormatted);
          totalKeterlambatanInMinutes += keterlambatanInMinutes;
          // totalKeterlambatan += keterlambatan;
        } else if (presensi.dateTimeMasuk!.hour == 0 &&
            presensi.dateTimeMasuk!.minute == 0) {
          keterlambatanList.add("00:00");
        } else {
          keterlambatanList.add("00:00");
        }

        if (presensi.dateTimeKeluar != null &&
            presensi.dateTimeKeluar!.minute != 0 &&
            presensi.dateTimeKeluar!.hour != 0 &&
            presensi.dateTimeKeluar!.isBefore(jadwalKeluar)) {
          var pulangLebihAwal =
              jadwalKeluar.difference(presensi.dateTimeKeluar!);
          var pulangLebihAwalInMinutes = pulangLebihAwal.inMinutes;
          var pulangLebihAwalFormatted =
              "${pulangLebihAwal.inHours.toString().padLeft(2, '0')}:${pulangLebihAwal.inMinutes.remainder(60).toString().padLeft(2, '0')}";
          pulangLebihAwalList.add(pulangLebihAwalFormatted);
          totalPulangLebihAwalInMinutes += pulangLebihAwalInMinutes;
          // totalPulangLebihAwal += pulangLebihAwal;
        } else if (presensi.dateTimeKeluar!.hour == 0 &&
            presensi.dateTimeKeluar!.minute == 0) {
          pulangLebihAwalList.add("00:00");
        } else {
          pulangLebihAwalList.add("00:00");
        }
      } else {
        keterlambatanList.add("00:00");
        pulangLebihAwalList.add("00:00");
      }
    }
  }

  Future<void> getPercentagePresence() async {
    QuerySnapshot<Map<String, dynamic>> presensiSnapshot;
    QuerySnapshot<Map<String, dynamic>> holidaySnapshot;
    QuerySnapshot<Map<String, dynamic>> jamKerjaSnapshot;
    QuerySnapshot<Map<String, dynamic>> pengecualianSnapshot;
    final previousMonth = DateTime(now.year, now.month - 1, 1);
    final nowMonth = DateTime(now.year, now.month, 1);
    start = previousMonth;
    end.value = nowMonth;

    pin.value = authC.userData.value.pin!;

    if (start == null) {
      presensiSnapshot = await firestore
          .collection('Kepegawaian')
          .doc(pin.value)
          .collection('Presensi')
          .where("date_time", isLessThan: end.value.toIso8601String())
          .orderBy("date_time", descending: false)
          .get();
    } else {
      presensiSnapshot = await firestore
          .collection('Kepegawaian')
          .doc(pin.value)
          .collection('Presensi')
          .where("date_time", isGreaterThan: start!.toIso8601String())
          .where("date_time",
              isLessThan:
                  end.value.add(const Duration(days: 1)).toIso8601String())
          .orderBy("date_time", descending: false)
          .get();
    }

    List<PresensiModel> presensiData = presensiSnapshot.docs
        .map((e) => PresensiModel.fromJson(e.data()))
        .toList();

    List<GroupedPresensiModel> groupedData = groupAttendanceData(presensiData);

    List<GroupedPresensiModel> combinedData = [];

    for (DateTime date = start!;
        date.isBefore(end.value) || isSameDay(date, end.value);
        date = date.add(const Duration(days: 1))) {
      if (date.weekday == DateTime.sunday) {
        continue;
      }
      bool isPresensiExist = false;

      for (var presensi in groupedData) {
        if (presensi.dateTimeMasuk != null &&
            isSameDay(presensi.dateTimeMasuk!, date)) {
          combinedData.add(presensi);
          isPresensiExist = true;
          break;
        }
      }

      if (!isPresensiExist) {
        combinedData.add(GroupedPresensiModel(
          pin: pin.value,
          dateTimeMasuk: DateTime(date.year, date.month, date.day),
          dateTimeKeluar: DateTime(date.year, date.month, date.day),
        ));
      }
    }

    DocumentSnapshot<Map<String, dynamic>> kepegawaianSnapshot =
        await firestore.collection('Kepegawaian').doc(pin.value).get();

    final KepegawaianModel kepgData =
        KepegawaianModel.fromSnapshot(kepegawaianSnapshot);

    jamKerjaSnapshot = await firestore.collection('JamKerja').get();

    jamKerjaList = jamKerjaSnapshot.docs
        .map((doc) => JamKerjaModel.fromJson(doc))
        .toList();

    holidaySnapshot = await firestore.collection('Holiday').get();

    holidayList =
        holidaySnapshot.docs.map((doc) => HolidayModel.fromJson(doc)).toList();

    pengecualianSnapshot = await firestore.collection('Pengecualian').get();

    pengecualianList = pengecualianSnapshot.docs
        .map((doc) => PengecualianModel.fromJson(doc))
        .toList();

    PengecualianModel pengecualianData = pengecualianList.firstWhere(
        (pengecualian) =>
            pengecualian.statusPengecualian == 'Ya' &&
            pengecualian.dateStart!.year == start!.year &&
            pengecualian.dateEnd!.year == start!.year);

    final int totalPresensi = combinedData.length;
    int hadirCountHoliday = 0;
    int tidakHadirCount = 0;

    for (var presensi in combinedData) {
      hitungKeterlambatanPulangLebihAwal(combinedData, kepgData);
      var date = presensi.dateTimeMasuk!.toIso8601String().split('T')[0];

      generateDateRangePengecualian(pengecualianRangeList, pengecualianData);
      var dateTimePresensi = presensi.dateTimeMasuk!;

      var isHolidayPengecualian = pengecualianRangeList.any((pengecualian) =>
          pengecualian.date == dateTimePresensi &&
          kepgData.kepegawaian == "NON-PNS");
      var isHoliday = holidayList.any((holiday) => holiday.date == date);

      var isAbsen = !isHoliday &&
          !isHolidayPengecualian &&
          presensi.dateTimeMasuk!.hour == 0 &&
          presensi.dateTimeMasuk!.minute == 0 &&
          presensi.dateTimeKeluar!.hour == 0 &&
          presensi.dateTimeKeluar!.minute == 0;

      if (isHoliday) {
        hadirCountHoliday++;
      } else if (isAbsen) {
        tidakHadirCount++;
      }
    }

    if (kDebugMode) {
      print('hadirCount: ${groupedData.length}');
      print('tidakHadirCount: $tidakHadirCount');
      print('totalPresensi: $totalPresensi');
    }

    double persentaseKetidakhadiran = (tidakHadirCount / totalPresensi) * 100;
    double persentaseKehadiran = 100 - persentaseKetidakhadiran;

    percentageList.value.clear();
    percentageList.value = [
      PercentageModel('Hadir', persentaseKehadiran),
      PercentageModel('Tidak Hadir', persentaseKetidakhadiran),
    ];

    for (var percent in percentageList) {
      if (kDebugMode) {
        print(percent.percentage);
      }
    }
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
