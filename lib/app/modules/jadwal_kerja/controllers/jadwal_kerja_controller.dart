import 'package:checkbox_grouped/checkbox_grouped.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';

import '../../../data/models/firestorejadwalkerjamodel.dart';
import '../../../theme/textstyle.dart';
import '../../../utils/dialogDefault.dart';

class JadwalKerjaController extends GetxController {
  //TODO: Implement JadwalKerjaController

  FirebaseFirestore firestore = FirebaseFirestore.instance;

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

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> addJadker(
      String namaJadker, String kodeJadker, String keterangan) async {
    CollectionReference jadker = firestore.collection("JadwalKerja");

    // selectedDays.forEach((String day) async {
    await jadker.doc(kodeJadker).set({
      'namaJadker': namaJadker,
      'kodeJadker': kodeJadker,
      'keterangan': keterangan,
      'hari': selectedDays.value,
    }).then((value) async {
      Get.dialog(dialogAlertBtn(() {
        // isSuccess = true;
        // completer.complete(true);
        Get.back();
        Get.back();
      },
          IconlyLight.tick_square,
          111.29,
          "OK",
          "Berhasil menambahkan Data Kepegawaian!",
          null,
          getTextAlert(Get.context!),
          null,
          getTextAlertBtn(Get.context!)));
    }).catchError((e) {
      // isSuccess = false;
      // completer.complete(false);
      if (kDebugMode) {
        print(e);
      }
      Get.dialog(dialogAlertOnlySingleMsg(IconlyLight.danger,
          "Gagal menambahkan Data.", getTextAlert(Get.context!)));
    });
    // });
    // isSuccess = await completer.future;
    // return isSuccess;
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
