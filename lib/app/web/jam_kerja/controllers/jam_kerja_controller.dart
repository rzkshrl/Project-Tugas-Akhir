// ignore_for_file: unnecessary_overrides

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:monitorpresensi/app/data/models/firestorejamkerjamodel.dart';
import 'package:monitorpresensi/app/utils/stringGlobal.dart';

import '../../../theme/textstyle.dart';
import '../../../utils/dialogDefault.dart';

class JamKerjaController extends GetxController {
  late Future<List<JamKerjaModel>> firestoreJamKerjaList;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  void onInit() {
    super.onInit();
    firestoreJamKerjaList = getFirestoreJamKerjaList();
  }

  Future<List<JamKerjaModel>> getFirestoreJamKerjaList() async {
    QuerySnapshot querySnapshot = await firestore
        .collection('JamKerja')
        .orderBy('hariKerja', descending: true)
        .get();
    List<JamKerjaModel> jamKerjaList = querySnapshot.docs
        .map((documentSnapshot) => JamKerjaModel.fromJson(documentSnapshot))
        .toList();
    return jamKerjaList;
  }

  final isChecked = false.obs;

  var sortColumnIndex = 0.obs;
  var sortAscending = true.obs;

  void sortData(int columnIndex, bool ascending) {
    sortColumnIndex.value = columnIndex;
    sortAscending.value = ascending;
    update();
  }

  final List<String> daysOfWeek = [
    senin,
    selasa,
    rabu,
    kamis,
    jumat,
    sabtu,
    minggu,
  ];

  var selectedDays = [].obs;
  Rx<String?> selectedDay = ''.obs;

  void toggleDay(String day) {
    if (selectedDays.contains(day)) {
      selectedDays.remove(day);
    } else {
      selectedDays.add(day);
    }
    selectedDays.refresh();
  }

  void resetSelectedDay() {
    selectedDay.value = null;
  }

  bool isDaysSelected(String day) {
    return selectedDays.contains(day);
  }

  bool isDaySelected(String day) {
    return selectedDay.value == day;
  }

  bool isAtLeastOneDaySelected() {
    return selectedDays.isNotEmpty;
  }

  void setSelectedDayFromFirestore(String day) {
    selectedDay.value = day;
  }

  void getJamKerja(String doc) {
    firestore.collection('JamKerja').doc(doc).get().then((docSnapshot) {
      final data = docSnapshot.data();
      if (data != null && data.containsKey('hariKerja')) {
        setSelectedDayFromFirestore(data['hariKerja']);
      }
    });
  }

  Future<void> addJamKerja(
      String namaJamKerja,
      String kepegawaianJamKerja,
      String ketJamKerja,
      String masukJamKerja,
      String keluarJamKerja,
      String batasAwalMasukJamKerja,
      String batasAwalKeluarJamKerja,
      String batasAkhirMasukJamKerja,
      String batasAkhirKeluarJamKerja,
      String terlambatJamKerja,
      String pulLebihAwalJamKerja) async {
    try {
      var jamkerja = firestore.collection('JamKerja');

      final docRef = jamkerja.doc();
      final checkData = await docRef.get();

      if (kDebugMode) {
        print(selectedDay);
      }

      if (checkData.exists == false) {
        await docRef.set({
          'nama': namaJamKerja,
          'kepegawaian': kepegawaianJamKerja,
          'ket': ketJamKerja,
          'jadwal_masuk': masukJamKerja,
          'jadwal_keluar': keluarJamKerja,
          'batasAwal_masuk': batasAwalMasukJamKerja,
          'batasAwal_keluar': batasAwalKeluarJamKerja,
          'batasAkhir_masuk': batasAkhirMasukJamKerja,
          'batasAkhir_keluar': batasAkhirKeluarJamKerja,
          'keterlambatan': terlambatJamKerja,
          'pulang_awal': pulLebihAwalJamKerja,
          'hariKerja': selectedDay.value.toString(),
          'id': docRef.id
        });
        Get.dialog(
          dialogAlertBtnSingleMsgAnimation('assets/lootie/finish.json',
              'Berhasil Menambahkan Data!', getTextAlert(Get.context!), () {
            Get.back();
            Get.back();
          }),
        );
      } else {
        Get.dialog(dialogAlertOnlySingleMsgAnimation(
            'assets/lootie/warning.json',
            "Data sudah ada.",
            getTextAlert(Get.context!)));
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      Get.dialog(dialogAlertOnlySingleMsgAnimation('assets/lootie/warning.json',
          "Terjadi Kesalahan!.", getTextAlert(Get.context!)));
    }
  }

  Future<void> editJamKerja(
      String doc,
      String namaJamKerja,
      String kepegawaianJamKerja,
      String ketJamKerja,
      String masukJamKerja,
      String keluarJamKerja,
      String batasAwalMasukJamKerja,
      String batasAwalKeluarJamKerja,
      String batasAkhirMasukJamKerja,
      String batasAkhirKeluarJamKerja,
      String terlambatJamKerja,
      String pulLebihAwalJamKerja) async {
    try {
      var jamkerja = firestore.collection('JamKerja');

      if (kDebugMode) {
        print(selectedDay);
      }

      await jamkerja.doc(doc).update({
        'nama': namaJamKerja,
        'kepegawaian': kepegawaianJamKerja,
        'ket': ketJamKerja,
        'jadwal_masuk': masukJamKerja,
        'jadwal_keluar': keluarJamKerja,
        'batasAwal_masuk': batasAwalMasukJamKerja,
        'batasAwal_keluar': batasAwalKeluarJamKerja,
        'batasAkhir_masuk': batasAkhirMasukJamKerja,
        'batasAkhir_keluar': batasAkhirKeluarJamKerja,
        'keterlambatan': terlambatJamKerja,
        'pulang_awal': pulLebihAwalJamKerja,
        'hariKerja': selectedDay.value.toString()
      });
      Get.dialog(
        dialogAlertBtnSingleMsgAnimation('assets/lootie/finish.json',
            'Berhasil Mengubah Data!', getTextAlert(Get.context!), () {
          Get.back();
          Get.back();
        }),
      );
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      Get.dialog(dialogAlertOnlySingleMsgAnimation('assets/lootie/warning.json',
          "Terjadi Kesalahan!.", getTextAlert(Get.context!)));
    }
  }

  Future<void> deleteJamKerja(String doc) async {
    Get.dialog(dialogAlertDualBtn(() async {
      Get.back();
    }, () async {
      Get.back();
      try {
        await firestore.collection('JamKerja').doc(doc).delete();
        Get.dialog(
          dialogAlertBtnSingleMsgAnimation('assets/lootie/finish.json',
              'Berhasil Menghapus Data!', getTextAlert(Get.context!), () {
            Get.back();
          }),
        );
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
        Get.dialog(dialogAlertOnlySingleMsgAnimation(
            'assets/lootie/warning.json',
            "Terjadi Kesalahan!.",
            getTextAlert(Get.context!)));
      }
    },
        IconlyLight.danger,
        111.29,
        'Batal',
        111.29,
        'OK',
        'Peringatan!',
        'Apakah anda yakin ingin menghapus data?',
        getTextAlert(Get.context!),
        getTextAlertSub(Get.context!),
        getTextAlertBtn(Get.context!),
        getTextAlertBtn2(Get.context!)));
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
