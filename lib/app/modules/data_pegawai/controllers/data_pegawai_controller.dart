import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:project_tugas_akhir/app/utils/dialogDefault.dart';

import '../../../data/models/firestorescanlogmodel.dart';
import '../../../theme/textstyle.dart';

class DataPegawaiController extends GetxController {
  //TODO: Implement DataPegawaiController

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  bool isSuccess = false;
  Completer<bool> completer = Completer<bool>();
  late Stream<List<KepegawaianModel>> firestoreKepegawaianList;
  var isLoading = true.obs;

  Future<void> addPegawai(BuildContext context, String nama, String pin,
      String jadker, String nip, String bidang, String email) async {
    try {
      CollectionReference pegawai = firestore.collection("Kepegawaian");

      final DocumentReference docRef = pegawai.doc(pin);
      final checkData = await docRef.get();

      if (checkData.exists == false) {
        await pegawai.doc(pin).set({
          'nama': nama,
          'pin': pin,
          'jadker': jadker,
          'nip': nip,
          'bidang': bidang,
          'email': email
        });
        Get.dialog(
          dialogAlertBtnSingleMsgAnimation('assets/lootie/finish.json',
              'Berhasil Menambahkan Data!', getTextAlert(Get.context!), () {
            Get.back();
          }),
        );
      } else {
        Get.dialog(dialogAlertOnlySingleMsg(
            IconlyLight.danger, "Data sudah ada.", getTextAlert(context)));
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      Get.dialog(dialogAlertOnlySingleMsg(IconlyLight.danger,
          "Terjadi Kesalahan!.", getTextAlert(Get.context!)));
    }
  }

  Future<void> editPegawai(
      String docIdentify,
      BuildContext context,
      String nama,
      String jadker,
      String nip,
      String bidang,
      String email) async {
    CollectionReference pegawai = firestore.collection("Kepegawaian");

    await pegawai.doc(docIdentify).update({
      'nama': nama,
      'jadker': jadker,
      'nip': nip,
      'bidang': bidang,
      'email': email
    });
    Get.dialog(
      dialogAlertBtnSingleMsgAnimation('assets/lootie/finish.json',
          'Berhasil Mengubah Data!', getTextAlert(Get.context!), () {
        Get.back();
      }),
    );
  }

  Future<void> deleteDoc(String doc) async {
    Get.dialog(dialogAlertDualBtn(() async {
      Get.back();
    }, () async {
      Get.back();
      try {
        await firestore.collection('Kepegawaian').doc(doc).delete();
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
    firestoreKepegawaianList = firestore
        .collection('Kepegawaian')
        .snapshots()
        .map((querySnapshot) => querySnapshot.docs
            .map((documentSnapshot) =>
                KepegawaianModel.fromSnapshot(documentSnapshot))
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
