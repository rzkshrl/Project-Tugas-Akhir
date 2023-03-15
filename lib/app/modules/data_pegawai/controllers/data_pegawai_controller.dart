import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DataPegawaiController extends GetxController {
  //TODO: Implement DataPegawaiController

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  void addPegawai(BuildContext context, String nama, String pin, String jadker,
      String nip, String bidang, String email) {
    try {
      CollectionReference pegawai = firestore.collection("Kepegawaian");

      // if (pegawai.) {

      // }

      pegawai.doc(pin).set({
        'nama': nama,
        'pin': pin,
        'jadker': jadker,
        'nip': nip,
        'bidang': bidang,
        'email': email
      });
    } catch (e) {}
  }

  @override
  void onInit() {
    super.onInit();
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
