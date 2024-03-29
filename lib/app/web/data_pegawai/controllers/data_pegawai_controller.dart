// ignore_for_file: use_build_context_synchronously, unnecessary_overrides

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:monitorpresensi/app/utils/dialogDefault.dart';

import '../../../data/models/firestorescanlogmodel.dart';
import '../../../theme/textstyle.dart';
import '../../../utils/kepegawaianDTS.dart';

class DataPegawaiController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  bool isSuccess = false;
  Completer<bool> completer = Completer<bool>();
  late Stream<List<KepegawaianModel>> firestoreKepegawaianList;
  var isLoading = true.obs;

  late KepegawaianDTS dts;

  var sortColumnIndex = 0.obs;
  var sortAscending = true.obs;

  void sortData(int columnIndex, bool ascending) {
    sortColumnIndex.value = columnIndex;
    sortAscending.value = ascending;
    update();
  }

  Future<void> addPegawai(BuildContext context, String nama, String pin,
      String kepg, String nip, String bidang) async {
    try {
      CollectionReference pegawai = firestore.collection("Kepegawaian");

      final DocumentReference docRef = pegawai.doc(pin);
      final checkData = await docRef.get();

      if (checkData.exists == false) {
        await pegawai.doc(pin).set({
          'nama': nama,
          'pin': pin,
          'kepegawaian': kepg,
          'nip': nip,
          'bidang': bidang,
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
            getTextAlert(context)));
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      Get.dialog(dialogAlertOnlySingleMsgAnimation('assets/lootie/warning.json',
          "Terjadi Kesalahan!.", getTextAlert(Get.context!)));
    }
  }

  Future<void> editPegawai(String docIdentify, BuildContext context,
      String nama, String kepg, String nip, String bidang) async {
    CollectionReference pegawai = firestore.collection("Kepegawaian");

    await pegawai.doc(docIdentify).update({
      'nama': nama,
      'kepegawaian': kepg,
      'nip': nip,
      'bidang': bidang,
    });
    Get.dialog(
      dialogAlertBtnSingleMsgAnimation('assets/lootie/finish.json',
          'Berhasil Mengubah Data!', getTextAlert(Get.context!), () {
        Get.back();
        Get.back();
      }),
    );
  }

  Future<void> deleteDoc(String doc) async {
    Get.dialog(dialogAlertDualBtnAnimation(() async {
      Get.back();
    }, () async {
      Get.back();
      try {
        await firestore.collection('Kepegawaian').doc(doc).delete();
        Get.dialog(
          dialogAlertBtnSingleMsgAnimation('assets/lootie/finish.json',
              'Berhasil Menghapus Data!', getTextAlert(Get.context!), () {
            Get.back();
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
        'assets/lootie/warning.json',
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
    // firestoreKepegawaianList = getFirestoreKepegawaianList();
    firestoreKepegawaianList = firestore
        .collection('Kepegawaian')
        .snapshots()
        .map((querySnapshot) => querySnapshot.docs
            .map((documentSnapshot) =>
                KepegawaianModel.fromSnapshot(documentSnapshot))
            .toList());
  }

  Future<List<KepegawaianModel>> getFirestoreKepegawaianList() async {
    QuerySnapshot querySnapshot =
        await firestore.collection('Kepegawaian').get();
    List<KepegawaianModel> kepegawaianList = querySnapshot.docs
        .map((documentSnapshot) =>
            KepegawaianModel.fromSnapshot(documentSnapshot))
        .toList();
    return kepegawaianList;
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
