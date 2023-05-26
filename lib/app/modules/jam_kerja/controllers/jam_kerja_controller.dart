import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:project_tugas_akhir/app/data/models/firestorejamkerjamodel.dart';

import '../../../theme/textstyle.dart';
import '../../../utils/dialogDefault.dart';

class JamKerjaController extends GetxController {
  //TODO: Implement JamKerjaController

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late Stream<List<JamKerjaModel>> firestoreJamKerjaList;

  final isChecked = false.obs;

  final List<String> daysOfWeek = [
    'Senin',
    'Selasa',
    'Rabu',
    'Kamis',
    'Jumat',
    'Sabtu',
    'Minggu',
  ];

  var selectedDays = [].obs;

  void toggleDay(String day) {
    if (selectedDays.contains(day)) {
      selectedDays.remove(day);
    } else {
      selectedDays.add(day);
    }
    selectedDays.refresh();
  }

  bool isDaySelected(String day) {
    return selectedDays.contains(day);
  }

  bool isAtLeastOneDaySelected() {
    return selectedDays.isNotEmpty;
  }

  Future<void> addJamKerja(
      String namaJamKerja,
      String kodeJamKerja,
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

      final DocumentReference docRef = jamkerja.doc(kodeJamKerja);
      final checkData = await docRef.get();
      print(selectedDays);

      if (checkData.exists == false) {
        await jamkerja.doc(kodeJamKerja).set({
          'nama': namaJamKerja,
          'kode': kodeJamKerja,
          'ket': ketJamKerja,
          'jadwal_masuk': masukJamKerja,
          'jadwal_keluar': keluarJamKerja,
          'batasAwal_masuk': batasAwalMasukJamKerja,
          'batasAwal_keluar': batasAwalKeluarJamKerja,
          'batasAkhir_masuk': batasAkhirMasukJamKerja,
          'batasAkhir_keluar': batasAkhirKeluarJamKerja,
          'keterlambatan': terlambatJamKerja,
          'pulang_awal': pulLebihAwalJamKerja,
          'hariKerja': selectedDays.toList()
        });
        Get.dialog(
          dialogAlertBtnSingleMsgAnimation('assets/lootie/finish.json',
              'Berhasil Menambahkan Data!', getTextAlert(Get.context!), () {
            Get.back();
            Get.back();
          }),
        );
      } else {
        Get.dialog(dialogAlertOnlySingleMsg(
            IconlyLight.danger, "Data sudah ada.", getTextAlert(Get.context!)));
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      Get.dialog(dialogAlertOnlySingleMsg(IconlyLight.danger,
          "Terjadi Kesalahan!.", getTextAlert(Get.context!)));
    }
  }

  Future<void> editJamKerja(
      String doc,
      String namaJamKerja,
      String kodeJamKerja,
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
      print(selectedDays);

      await jamkerja.doc(doc).update({
        'nama': namaJamKerja,
        'kode': kodeJamKerja,
        'ket': ketJamKerja,
        'jadwal_masuk': masukJamKerja,
        'jadwal_keluar': keluarJamKerja,
        'batasAwal_masuk': batasAwalMasukJamKerja,
        'batasAwal_keluar': batasAwalKeluarJamKerja,
        'batasAkhir_masuk': batasAkhirMasukJamKerja,
        'batasAkhir_keluar': batasAkhirKeluarJamKerja,
        'keterlambatan': terlambatJamKerja,
        'pulang_awal': pulLebihAwalJamKerja,
        'hariKerja': selectedDays.toList()
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
      Get.dialog(dialogAlertOnlySingleMsg(IconlyLight.danger,
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
        Get.dialog(dialogAlertOnlySingleMsg(IconlyLight.danger,
            "Terjadi Kesalahan!.", getTextAlert(Get.context!)));
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
  void onInit() {
    super.onInit();
    firestoreJamKerjaList = firestore.collection('JamKerja').snapshots().map(
        (querySnapshot) => querySnapshot.docs
            .map((documentSnapshot) => JamKerjaModel.fromJson(documentSnapshot))
            .toList());
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
