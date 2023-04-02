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
  final kepegawaianList = <KepegawaianModel>[].obs;
  var isLoading = true.obs;

  Future<void> addPegawai(BuildContext context, String nama, String pin,
      String jadker, String nip, String bidang, String email) async {
    CollectionReference pegawai = firestore.collection("Kepegawaian");

    print(pin);

    final QuerySnapshot checkData =
        await pegawai.where('pin', isEqualTo: pin).get();

    final List<DocumentSnapshot> documents = checkData.docs;

    if (documents.isEmpty) {
      await pegawai.doc(pin).set({
        'nama': nama,
        'pin': pin,
        'jadker': jadker,
        'nip': nip,
        'bidang': bidang,
        'email': email
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
            getTextAlert(context),
            null,
            getTextAlertBtn(context)));
      }).catchError((e) {
        // isSuccess = false;
        // completer.complete(false);
        if (kDebugMode) {
          print(e);
        }
        Get.dialog(dialogAlertOnlySingleMsg(IconlyLight.danger,
            "Gagal menambahkan Data.", getTextAlert(context)));
      });
    } else {
      Get.dialog(dialogAlertOnlySingleMsg(
          IconlyLight.danger, "Data sudah ada.", getTextAlert(context)));
    }
    // isSuccess = await completer.future;
    // return isSuccess;
  }

  Future<void> getData() async {
    firestore.collection('Kepegawaian').snapshots().listen((querySnap) {
      kepegawaianList.clear();
      for (var documentSnapshot in querySnap.docs) {
        KepegawaianModel kepegawaian =
            KepegawaianModel.fromSnapshot(documentSnapshot);
        kepegawaianList.add(kepegawaian);
      }
    });
  }

  @override
  void onInit() {
    super.onInit();
    getData();
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
