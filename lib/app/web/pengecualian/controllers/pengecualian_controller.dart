// ignore_for_file: unnecessary_overrides

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:intl/intl.dart';

import '../../../data/models/firestorepengecualianmodel.dart';
import '../../../theme/textstyle.dart';
import '../../../utils/dialogDefault.dart';
import '../../../utils/textfield.dart';

class PengecualianController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late Stream<List<PengecualianModel>> firestorePengecualianList;

  @override
  void onInit() {
    super.onInit();
    firestorePengecualianList = firestore
        .collection('Pengecualian')
        .orderBy('dateStart', descending: true)
        .snapshots()
        .map((querySnapshot) => querySnapshot.docs
            .map((documentSnapshot) =>
                PengecualianModel.fromJson(documentSnapshot))
            .toList());
  }

  DateTime? start;
  final end = DateTime.now().obs;
  final dateFormatter = DateFormat('d MMMM yyyy', 'id-ID');

  void pickRangeDate(DateTime pickStart, DateTime pickEnd) {
    start = pickStart;
    end.value = pickEnd;
    update();
    var startFormatted = dateFormatter.format(start!);
    var endFormatted = dateFormatter.format(end.value);
    textC.datepickerC.text = '$startFormatted - $endFormatted';
  }

  Future<void> addPengecualian(String nama, String statusPengecualian) async {
    try {
      var hariLibur = firestore.collection('Pengecualian');

      final DocumentReference docRef = hariLibur.doc(nama);
      final checkData = await docRef.get();

      if (checkData.exists == false) {
        await hariLibur.doc(nama).set({
          'nama': nama,
          'statusPengecualian': statusPengecualian,
          'dateStart': start!.toIso8601String(),
          'dateEnd': end.value.toIso8601String()
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

  Future<void> editPengecualian(
      String doc, String nama, String statusPengecualian) async {
    try {
      var hariLibur = firestore.collection('Pengecualian');

      await hariLibur.doc(nama).update({
        'nama': nama,
        'statusPengecualian': statusPengecualian,
        'dateStart': start!.toIso8601String(),
        'DateEnd': end.value.toIso8601String()
      });
      Get.dialog(
        dialogAlertBtnSingleMsgAnimation('assets/lootie/finish.json',
            'Berhasil Menambahkan Data!', getTextAlert(Get.context!), () {
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

  Future<void> deletePengecualian(String doc) async {
    Get.dialog(dialogAlertDualBtn(() async {
      Get.back();
    }, () async {
      Get.back();
      try {
        await firestore.collection('Pengecualian').doc(doc).delete();
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
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
